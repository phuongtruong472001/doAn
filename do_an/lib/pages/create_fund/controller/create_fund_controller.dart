import 'package:do_an/database/database.dart';
import 'package:do_an/model/fund.dart';
import 'package:do_an/pages/fund/controller/fund_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/strings.dart';

class CreateFundController extends GetxController {
  Rx<Fund> fund = Fund().obs;
  final fundNameController = TextEditingController();
  final valueController = TextEditingController();
  DBHelper dbHelper = DBHelper();
  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  void initData() {
    if (Get.arguments != null && Get.arguments is Fund) {
      fundNameController.text = Get.arguments.name;
      valueController.text = Get.arguments.value.toString();
    }
  }

  Future<void> createFund() async {
    fund.value.name = fundNameController.text;
    fund.value.value = int.parse(valueController.text);
    bool status = await dbHelper.addFund(fund.value);
    if (status) {
      FundController fundController = Get.find<FundController>();
      await fundController.initData();
      Get.back();
    }
    Get.snackbar(
      "",
      status ? AppString.success("Ví tiền") : AppString.fail,
      backgroundColor: status ? Colors.green : Colors.red,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
