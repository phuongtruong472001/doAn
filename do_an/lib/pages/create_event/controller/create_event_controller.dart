import 'package:do_an/model/transaction.dart';
import 'package:do_an/pages/event/controller/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

import '../../../base/strings.dart';
import '../../../base_controller/base_controller.dart';
import '../../../database/database.dart';
import '../../../model/event.dart';

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

  @override
  void onReady() {}
  @override
  void onInit() {
    initData();
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
    event.value.date = selectedDate.value;
    if (formData.currentState!.validate()) {
      bool status;
      if (Get.arguments != null) {
        status = await dbHelper.editEvent(event.value);
      } else {
        status = await dbHelper.addEvent(event.value);
      }
      String messege = "";
      if (status) {
        if (Get.arguments == null) {
          messege = AppString.addSuccess("Sự kiện");
        } else {
          messege = AppString.editSuccess("Sự kiện");
        }

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
}
