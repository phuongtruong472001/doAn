import 'package:do_an/base/dimen.dart';
import 'package:do_an/base_controller/base_controller_src.dart';
import 'package:do_an/model/filter.dart';
import 'package:do_an/model/transaction.dart' as tr;
import 'package:do_an/pages/filter/view/filter_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../../../database/database.dart';
import '../../home/controller/home_controller.dart';

class TransactionController extends BaseSearchAppbarController {
  RxInt indexTabbar = 1.obs;
  String fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var dbHelper = DBHelper();
  DateTime date = DateTime.now();
  int page = 0;
  RxBool isFilter = false.obs;
  HomeController homeController = Get.find<HomeController>();
  RxMap<String, int> listThu = RxMap<String, int>();
  RxMap<String, int> listChi = RxMap<String, int>();

  @override
  void onInit() async {
    listChi.clear();
    listThu.clear();
    fromDate =
        DateFormat('yyyy-MM-dd').format(DateTime(date.year, date.month, 1));
    toDate = DateFormat('yyyy-MM-dd')
        .format(Jiffy(fromDate).add(months: 1, days: -1).dateTime);
    showLoading();
    await initData().whenComplete(() => hideLoading());
    super.onInit();
  }

  @override
  void onReady() {}

  Future<void> onTapped(int index) async {
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
    rxList.value =
        await dbHelper.getTransactions(fromDate, toDate, 0, defaultItemOfPage);
  }

  Future<void> initData() async {
    List<tr.Transaction> tempList =
        await dbHelper.getTransactions(fromDate, toDate, 0, defaultItemOfPage);
    rxList.value = tempList;
    for (tr.Transaction transaction in tempList) {
      caculatorThuChi(transaction);
    }
  }

  @override
  Future<void> onLoadMore() async {
    page++;
    var transactions = await dbHelper.getTransactions(
        fromDate, toDate, defaultItemOfPage * page, defaultItemOfPage);
    if (transactions.isNotEmpty) {
      rxList.addAll(transactions);
      for (tr.Transaction transaction in transactions) {
        caculatorThuChi(transaction);
      }
    }
    print(rxList.length);
    refreshController.loadComplete();
  }

  void caculatorThuChi(tr.Transaction transaction) {
    if (transaction.value! > 0) {
      listThu.update(
          DateFormat("yyyy-MM-dd").format(transaction.executionTime!),
          (value) => value + transaction.value!,
          ifAbsent: () => transaction.value!);
    } else {
      listChi.update(
          DateFormat("yyyy-MM-dd").format(transaction.executionTime!),
          (value) => value + transaction.value!,
          ifAbsent: () => transaction.value!);
    }
  }

  @override
  Future<void> onRefresh() async {
    page = 0;
    rxList.clear();
    listChi.clear();
    listThu.clear();
    await initData();
    refreshController.refreshCompleted();
  }

  @override
  Future<void> functionSearch() async {
    listChi.clear();
    listThu.clear;
    var transactions = await dbHelper.getTransactions(
        fromDate, toDate, 0, defaultItemOfPage,
        keySearch: textSearchController.text);
    if (transactions.isNotEmpty) {
      rxList.value = transactions;
      for (tr.Transaction transaction in transactions) {
        caculatorThuChi(transaction);
      }
    }
  }

  void deleteTransaction(tr.Transaction transaction) {
    Get.dialog(
      AlertDialog(
        title: const Text("Xác nhận"),
        content: const Text('Bạn có muốn xoá giao dịch này không?'),
        actions: [
          // The "Yes" button
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Huỷ')),
          TextButton(
              onPressed: () async {
                bool status = await dbHelper.deleteTransaction(transaction);
                if (status) {
                  Get.back();
                  showSnackBar("Xoá giao dịch thành công");
                  await initData();
                  homeController.initData();
                }
              },
              child: const Text('Xoá'))
        ],
      ),
    );
  }

  void showFilterPage() {
    Get.bottomSheet(
      const FilterPage(),
      //isScrollControlled: true,
    ).then((value) async {
      if (value is FilterItem) {
        isFilter.value = true;
        fromDate = value.fromDate;
        toDate = value.toDate;
        await initData();
      } else {
        indexTabbar.value = 1;
        isFilter.value = false;
        await onTapped(indexTabbar.value);
      }
    });
  }
}
