import 'package:do_an/model/transaction.dart';
import 'package:do_an/pages/event/controller/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/strings.dart';
import '../../../base_controller/base_controller.dart';
import '../../../database/database.dart';
import '../../../model/event.dart';
import '../../../service/local_notification_service.dart';

class CreateEventController extends GetxController {
  final formData = GlobalKey<FormState>();
  Rx<Event> event = Event().obs;
  var valueController = MoneyMaskedTextController(
      thousandSeparator: '.', precision: 0, decimalSeparator: "");
  final nameController = TextEditingController().obs;
  //final fundNameController = TextEditingController().obs;
  var choosedDate = false.obs;
  var selectedDate = DateTime.now().obs;
  DBHelper dbHelper = DBHelper();
  EventController eventController = Get.find<EventController>();
  RxList<Transaction> listTransaction = RxList<Transaction>.empty();
  late final LocalNotificationService service;
  Rx<TimeOfDay> time = const TimeOfDay(hour: 7, minute: 15).obs;

  @override
  void onReady() {}
  @override
  void onInit() {
    initData();
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();
    super.onInit();
  }

  void selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    choosedDate.value = true;
    if (picked != null && picked != DateTime.now()) {
      selectedDate.value = picked;
    }
  }

  Future<void> createEvent() async {
    event.value.name = nameController.value.text;
    event.value.estimateValue =
        int.parse(valueController.value.text.replaceAll('.', ''));
    event.value.date = DateTime(selectedDate.value.year,
            selectedDate.value.month, selectedDate.value.day)
        .add(
      Duration(
        hours: time.value.hour,
        minutes: time.value.minute,
      ),
    );
    if (formData.currentState!.validate()) {
      bool status = false;
      if (Get.arguments != null) {
        Get.dialog(
          AlertDialog(
            title: const Text("Xác nhận"),
            content: const Text('Bạn có muốn xoá giao dịch này không?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Huỷ')),
              TextButton(
                  onPressed: () async {
                    status = await dbHelper.editEvent(event.value);
                    if (status) {
                      Get.back();
                    }
                  },
                  child: const Text('Sửa'))
            ],
          ),
        );
      } else {
        status = await dbHelper.addEvent(event.value);
      }
      String messege = "";
      if (status) {
        if (Get.arguments == null) {
          messege = AppString.addSuccess("Sự kiện");
        } else {
          service.cancelNotification(event.value.id ?? 0);
          messege = AppString.editSuccess("Sự kiện");
        }
        await service.showScheduledNotification(
          id: event.value.id ?? 0,
          title: event.value.name ?? "",
          body:
              "Diễn ra vào ${DateFormat("kk:mm dd:MM:yyyy").format(event.value.date ?? DateTime.now())}",
          dateTime: event.value.date!
                  .isBefore(DateTime.now().add(const Duration(days: 1)))
              ? DateTime.now().add(const Duration(minutes: 1))
              : (event.value.date ?? DateTime.now())
                  .subtract(const Duration(days: 1)),
        );

        await eventController.initData();
        Get.back();
      } else {
        messege = AppString.fail;
      }
      showSnackBar(
        messege,
        backgroundColor: status ? Colors.green : Colors.red,
      );
    }
  }

  void initData() async {
    if (Get.arguments is Event) {
      event.value = Get.arguments;
      nameController.value.text = Get.arguments.name;
      valueController.text = Get.arguments.estimateValue.toString();
      selectedDate.value = Get.arguments.date;
      listTransaction.value =
          await dbHelper.getTransactionsOfEvent(event.value.id!);
    }
  }

  void completeEvent() async {
    int status;
    if (event.value.allowNegative == 1) {
      status = 0;
    } else {
      status = 1;
    }
    dbHelper.updateEventAllowNegative(event.value.id!, status);
    Get.back();
    await eventController.initData();
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);
  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
    }
  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time.value,
    );
    if (newTime != null) {
      time.value = newTime;
    }
  }
}
