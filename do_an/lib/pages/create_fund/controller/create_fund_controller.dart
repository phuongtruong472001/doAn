import 'package:do_an/database/database.dart';
import 'package:do_an/model/fund.dart';
import 'package:do_an/pages/fund/controller/fund_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

import '../../../base/strings.dart';

class CreateFundController extends GetxController {
  Rx<Fund> fund = Fund().obs;
  final fundNameController = TextEditingController();
  final valueController = MoneyMaskedTextController(
      thousandSeparator: '.', precision: 0, decimalSeparator: "");
  DBHelper dbHelper = DBHelper();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> createFund() async {
    fund.value.name = fundNameController.text;
    fund.value.value = int.parse(valueController.text.replaceAll('.', ''));
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
