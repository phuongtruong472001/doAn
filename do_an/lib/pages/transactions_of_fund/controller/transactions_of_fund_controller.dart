import 'package:do_an/model/fund.dart';
import 'package:do_an/model/transaction.dart';
import 'package:get/get.dart';

import '../../../database/database.dart';

class TransactionsOfFundController extends GetxController {
  RxList<Transaction> transactions = List<Transaction>.empty().obs;
  var dbHelper = DBHelper();
  RxString nameOfFund = "".obs;
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

  void initData() async {
    Fund fund = Fund();
    if (Get.arguments is Fund) {
      fund = Get.arguments;
      nameOfFund.value = fund.name!;
    }
    transactions.value = await dbHelper.getTransactionsOfFund(
      "",
      "",
      fund.id ?? 0,
    );
  }
}
