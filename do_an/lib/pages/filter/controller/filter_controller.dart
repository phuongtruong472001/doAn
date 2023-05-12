import 'package:do_an/pages/transaction/controller/transaction_controller.dart';
import 'package:do_an/pages/transactions_of_fund/controller/transactions_of_fund_controller.dart';
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
}
