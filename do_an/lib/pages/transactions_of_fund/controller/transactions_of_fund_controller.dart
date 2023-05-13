import 'package:do_an/base/dimen.dart';
import 'package:do_an/model/filter.dart';
import 'package:do_an/model/fund.dart';
import 'package:do_an/model/transaction.dart';
import 'package:do_an/pages/filter/view/filter_view.dart';
import 'package:do_an/pages/filter_of_fund/view/filter_of_fund_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base_controller/base_search_appbar_controller.dart';
import '../../../database/database.dart';

class TransactionsOfFundController extends BaseSearchAppbarController {
  var dbHelper = DBHelper();
  RxString nameOfFund = "".obs;
  int fundID = 0;
  int page = 0;
  RxMap<String, int> listThu = RxMap<String, int>();
  RxMap<String, int> listChi = RxMap<String, int>();
  RxBool isFilter = false.obs;
  late String fromDate ;
  late String toDate ;
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

  void caculatorThuChi(Transaction transaction) {
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

  Future<void> initData() async {
    showLoading();
    fromDate = '2021-01-01';
    toDate = '2025-01-01';
    Fund fund = Fund();
    if (Get.arguments is Fund) {
      fund = Get.arguments;
      nameOfFund.value = fund.name!;
      fundID = fund.id ?? 0;
    }
    var transactions = await dbHelper
        .getTransactionsOfFund(
          fund.id ?? 0,
          0,
          defaultItemOfPage,
          keySearch: textSearchController.text,
          fromDate: fromDate,
          toDate: toDate,
        )
        .whenComplete(() => hideLoading());
    if (transactions.isNotEmpty) {
      rxList.value = transactions;
      for (Transaction transaction in transactions) {
        caculatorThuChi(transaction);
      }
    }
  }

  @override
  Future<void> onLoadMore() async {
    page++;
    List<Transaction> transactions = await dbHelper.getTransactionsOfFund(
      fundID,
      defaultItemOfPage * page,
      defaultItemOfPage,
      keySearch: textSearchController.text,
      fromDate: fromDate,
      toDate: toDate,
    );
    if (transactions.isNotEmpty) {
      rxList.addAll(transactions);
      for (Transaction transaction in transactions) {
        caculatorThuChi(transaction);
      }
    }
    refreshController.loadComplete();
  }

  @override
  Future<void> onRefresh() async {
    page = 0;
    listChi.clear();
    listThu.clear;
    await initData();
    refreshController.refreshCompleted();
  }

  @override
  Future<void> functionSearch() async {
    listChi.clear();
    listThu.clear;
    var transactions = await dbHelper.getTransactionsOfFund(
      fundID,
      0,
      defaultItemOfPage,
      keySearch: textSearchController.text,
      fromDate: fromDate,
      toDate: toDate,
    );
    if (transactions.isNotEmpty) {
      rxList.value = transactions;
      for (Transaction transaction in transactions) {
        caculatorThuChi(transaction);
      }
    }
  }

  void showFilterPage() {
    Get.bottomSheet(
      const FilterOfFundPage(),
      //isScrollControlled: true,
    ).then((value) async {
      if (value is FilterItem) {
        listChi.clear();
        listThu.clear();
        fromDate = value.fromDate;
        toDate = value.toDate;
        isFilter.value = true;
        var transactions = await dbHelper
            .getTransactionsOfFund(
              fundID,
              0,
              defaultItemOfPage,
              keySearch: textSearchController.text,
              fromDate: fromDate,
              toDate: toDate,
            )
            .whenComplete(() => hideLoading());
        if (transactions.isNotEmpty) {
          rxList.value = transactions;
          for (Transaction transaction in transactions) {
            caculatorThuChi(transaction);
          }
        }
      } else {
        isFilter.value = false;
        await initData();
      }
    });
  }
}
