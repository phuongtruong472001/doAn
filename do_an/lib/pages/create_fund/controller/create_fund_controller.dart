import 'package:do_an/base_controller/base_controller.dart';
import 'package:do_an/database/database.dart';
import 'package:do_an/model/fund.dart';
import 'package:do_an/pages/fund/controller/fund_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

import '../../../base/strings.dart';

class CreateFundController extends BaseGetxController {
  final formData = GlobalKey<FormState>();
  Rx<Fund> fund = Fund().obs;
  final fundNameController = TextEditingController();
  final valueController = MoneyMaskedTextController(
      thousandSeparator: '.',
      precision: 0,
      decimalSeparator: "");
  DBHelper dbHelper = DBHelper();
  List<String> listWallet = [
    "Ví cơ bản",
    "Ví tín dụng",
    "Ví liên kết",
    "Ví tiết kiệm"
  ];
  RxInt typeWallet = 0.obs;

  Future<void> createFund() async {
    if (formData.currentState!.validate()) {
      fund.value.name = fundNameController.text;
      fund.value.icon = "${typeWallet.value}.png";
      fund.value.start = int.parse(valueController.text.replaceAll('.', ''));
      bool status = await dbHelper.addFund(fund.value);
      if (status) {
        FundController fundController = Get.find<FundController>();
        await fundController.initData();
        Get.back();
      }
      showSnackBar(
        status ? AppString.addSuccess("Ví tiền") : AppString.fail,
        backgroundColor: status ? Colors.green : Colors.red,
      );
    }
  }
}
