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

  Future<void> manageEvent() async {
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
      if (Get.arguments != null) {
        await editEvent();
      } else {
        await createEvent();
      }
    }
  }

  Future<void> createEvent() async {
    bool status = await dbHelper.addEvent(event.value);
    showSnackBar(
      status ? AppString.addSuccess("Sự kiện") : AppString.addFail("Sự kiện"),
      backgroundColor: status ? Colors.green : Colors.red,
    );
  }

  Future<void> editEvent() async {
    await Get.dialog(
      AlertDialog(
        title: const Text("Xác nhận"),
        content: const Text('Bạn có muốn sửa sự kiện này không?'),
        actions: [
          // The "Yes" button
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Huỷ')),
          TextButton(
              onPressed: () async {
                bool status = await dbHelper.editEvent(event.value);

                if (status) {
                  service.cancelNotification(event.value.id ?? 0);
                  await service.showScheduledNotification(
                    id: event.value.id ?? 0,
                    title: event.value.name ?? "",
                    body:
                        "Diễn ra vào ${DateFormat("kk:mm dd:MM:yyyy").format(event.value.date ?? DateTime.now())}",
                    dateTime: event.value.date!.isBefore(
                            DateTime.now().add(const Duration(days: 1)))
                        ? DateTime.now().add(const Duration(minutes: 1))
                        : (event.value.date ?? DateTime.now())
                            .subtract(const Duration(days: 1)),
                  );

                  Get.close(1);
                  Get.back();
                }
                showSnackBar(
                  status
                      ? AppString.editSuccess("Sự kiện")
                      : AppString.editFail("Sự kiện"),
                  backgroundColor: status ? Colors.green : Colors.red,
                );
              },
              child: const Text('Sửa'))
        ],
      ),
    );
  }

  void initData() async {
    if (Get.arguments is Event) {
      event.value = Get.arguments;
      nameController.value.text = Get.arguments.name;
      valueController.text = Get.arguments.estimateValue.toString();
      selectedDate.value = Get.arguments.date;
      time.value = TimeOfDay(
          hour: Get.arguments.date.hour, minute: Get.arguments.date.minute);
      listTransaction.value =
          await dbHelper.getTransactionsOfEvent(event.value.id!);
    }
  }

  void completeEvent() async {
    int status = event.value.allowNegative!;
    await Get.dialog(
      AlertDialog(
        title: const Text("Xác nhận"),
        content: Text(status == 0
            ? 'Bạn có muốn đánh dấu sự kiện này thành chưa hoàn thành không?'
            : 'Bạn có muốn hoàn thành sự kiện này không?'),
        actions: [
          // The "Yes" button
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Huỷ')),
          TextButton(
              onPressed: () async {
                if (event.value.allowNegative == 1) {
                  status = 0;
                } else {
                  status = 1;
                }
                Get.close(1);
                Get.back();
                await dbHelper.updateEventAllowNegative(
                    event.value.id!, status);
                showSnackBar("Cập nhật trạng thái thành công!",
                    duration: Duration(seconds: 1));
              },
              child: const Text('Cập nhật'))
        ],
      ),
    );
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
