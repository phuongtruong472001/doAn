import 'package:do_an/model/transaction.dart';
import 'package:do_an/pages/transaction/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base_controller/base_controller.dart';

class FilterController extends BaseGetxController {
  late RxString fromDateStr;
  late RxString toDateStr;
  TransactionController transactionController =
      Get.find<TransactionController>();
  @override
  void onInit() {
    fromDateStr = transactionController.fromDate.obs;
    toDateStr = transactionController.toDate.obs;
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> selectTime(String timeOfDay, Function(TimeOfDay p1) func) async {
    await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay(
        hour: int.tryParse(timeOfDay.split(':').first) ?? DateTime.now().hour,
        minute:
            int.tryParse(timeOfDay.split(':').last) ?? DateTime.now().minute,
      ),
    ).then((value) {
      if (value != null) {
        func.call(value);
      }
    });
  }
}
