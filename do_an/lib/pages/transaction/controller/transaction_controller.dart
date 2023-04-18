import 'package:do_an/model/transaction.dart' as tr;
import 'package:do_an/routes/routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../database/database.dart';

class TransactionController extends GetxController {
  RxInt indexTabbar = 0.obs;
  RxList<tr.Transaction> transactions = List<tr.Transaction>.empty().obs;
  String fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
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

  void goToDetail(tr.Transaction transaction) {
    Get.toNamed(AppRoutes.createTransaction, arguments: transaction);
  }

  Future<void> initData() async {
    var dbHelper = DBHelper();
    List<tr.Transaction> listTransaction =
        await dbHelper.getTransactions(fromDate, toDate);
    //dbHelper.getTotalValueOfCategory(0, "", "");
    transactions.value = listTransaction;
  }
}
