import 'package:do_an/base_controller/base_controller_src.dart';
import 'package:do_an/model/transaction.dart' as tr;
import 'package:do_an/routes/routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../../database/database.dart';

class TransactionController extends BaseSearchAppbarController {
  RxInt indexTabbar = 1.obs;
  String fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var dbHelper = DBHelper();
  DateTime date = DateTime.now();
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
        toDate = '2025-01-01';
        break;
    }
    print("$fromDate-----$toDate");
    rxList.value = await dbHelper.getTransactions(fromDate, toDate);
  }

  void goToDetail(tr.Transaction transaction) {
    Get.toNamed(AppRoutes.createTransaction, arguments: transaction);
  }

  Future<void> initData() async {
    fromDate =
        DateFormat('yyyy-MM-dd').format(DateTime(date.year, date.month, 1));
    toDate = DateFormat('yyyy-MM-dd')
        .format(Jiffy(fromDate).add(months: 1, days: -1).dateTime);
    List<tr.Transaction> listTransaction =
        await dbHelper.getTransactions(fromDate, toDate);
    //dbHelper.getTotalValueOfCategory(0, "", "");
    rxList.value = listTransaction;
  }

  @override
  Future<void> onLoadMore() async {
    refreshController.loadComplete();
  }

  @override
  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
  }

  @override
  Future<void> functionSearch() async {
    rxList.value = await dbHelper.getTransactions(fromDate, toDate,
        keySearch: textSearchController.text);
  }

  void deleteTransaction(tr.Transaction transaction) async {
    bool status = await dbHelper.deleteTransaction(transaction);
    if (status) {
      initData();
    }
  }
}
