import 'package:do_an/model/transaction.dart' as tr;
import 'package:do_an/routes/routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../../../database/database.dart';

class TransactionController extends GetxController {
  RxInt indexTabbar = 1.obs;
  RxList<tr.Transaction> transactions = List<tr.Transaction>.empty().obs;
  String fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var dbHelper = DBHelper();
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

  void onTapped(int index) async {
    indexTabbar.value = index;
    DateTime date = DateTime.now();
    switch (indexTabbar.value) {
      case 0:
        fromDate = DateFormat('yyyy-MM-dd')
            .format(DateTime(date.year, date.month - 1, 1));
        toDate = DateFormat('yyyy-MM-dd')
            .format(Jiffy(fromDate).add(months: 1, days: -1).dateTime);
        break;
      case 1:
        fromDate =
            DateFormat('yyyy-MM-dd').format(DateTime(date.year, date.month, 1));
        toDate = DateFormat('yyyy-MM-dd')
            .format(Jiffy(fromDate).add(months: 1, days: -1).dateTime);
        break;
      case 2:
        fromDate = DateFormat('yyyy-MM-dd')
            .format(DateTime(date.year, date.month, date.day + 1));
        toDate = '2023-01-01';
        break;
    }
    transactions.value = await dbHelper.getTransactions(fromDate, toDate);
  }

  void goToDetail(tr.Transaction transaction) {
    Get.toNamed(AppRoutes.createTransaction, arguments: transaction);
  }

  Future<void> initData() async {
    List<tr.Transaction> listTransaction =
        await dbHelper.getTransactions(fromDate, toDate);
    //dbHelper.getTotalValueOfCategory(0, "", "");
    transactions.value = listTransaction;
  }
}
