import 'package:do_an/pages/event/controller/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

import '../../../base/strings.dart';
import '../../../database/database.dart';
import '../../../model/event.dart';

class CreateEventController extends GetxController {
  Rx<Event> event = Event().obs;
  var valueController = MoneyMaskedTextController(
      thousandSeparator: '.', precision: 0, decimalSeparator: "");
  final nameController = TextEditingController().obs;
  //final fundNameController = TextEditingController().obs;
  var choosedDate = false.obs;
  var selectedDate = DateTime.now().obs;
  DBHelper dbHelper = DBHelper();

  @override
  void onReady() {}

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
    event.value.estimateValue = int.parse(valueController.value.text.replaceAll('.', ''));
    event.value.date = selectedDate.value;
    bool status = await dbHelper.addEvent(event.value);
    if (status) {
      EventController eventController = Get.find<EventController>();
      await eventController.initData();
      Get.back();
    }
    Get.snackbar(
      "",
      status ? AppString.success("Sự kiện") : AppString.fail,
      backgroundColor: status ? Colors.green : Colors.red,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void initData() {
    if (Get.arguments != null && Get.arguments is Event) {
      nameController.value.text = Get.arguments.name;
      valueController.text = Get.arguments.estimateValue;
      selectedDate.value = DateTime.parse(Get.arguments.date);
    }
  }

  // void chooseFund() {
  //   Get.toNamed(AppRoutes.fund, arguments: true)!.then((value) {
  //     if (value != null) {
  //       event.update((val) {
  //         val!.fundID = value.id;
  //         val.fundName = value.name;
  //       });
  //     }
  //   });
  // }
}
