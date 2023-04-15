import 'package:do_an/model/transaction.dart' as tr;
import 'package:get/get.dart';

import '../../../database/database.dart';

class TransactionController extends GetxController {
  RxInt indexTabbar = 0.obs;
  RxList<tr.Transaction> transactions = List<tr.Transaction>.empty().obs;
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

  void onTapped(int index) {
    indexTabbar.value = index;
  }

  Future<void> initData() async {
    var dbHelper = DBHelper();
    List<tr.Transaction> listTransaction = await dbHelper.getTransactions();
    transactions.value = listTransaction;
  }
}
