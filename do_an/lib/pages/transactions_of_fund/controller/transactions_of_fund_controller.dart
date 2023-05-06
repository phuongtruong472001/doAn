import 'package:do_an/base/dimen.dart';
import 'package:do_an/model/fund.dart';
import 'package:do_an/model/transaction.dart';
import 'package:get/get.dart';

import '../../../base_controller/base_search_appbar_controller.dart';
import '../../../database/database.dart';

class TransactionsOfFundController extends BaseSearchAppbarController {
  var dbHelper = DBHelper();
  RxString nameOfFund = "".obs;
  int fundID = 0;
  int page = 0;
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
      fundID = fund.id ?? 0;
    }
    rxList.value = await dbHelper.getTransactionsOfFund(
      fund.id ?? 0,
      0,
      defaultItemOfPage,
    );
  }

  @override
  Future<void> onLoadMore() async {
    page++;
    List<Transaction> transactions = await dbHelper.getTransactionsOfFund(
        fundID, defaultItemOfPage * page, defaultItemOfPage);
    rxList.addAll(transactions);
    refreshController.loadComplete();
  }

  @override
  Future<void> onRefresh() async {
    page = 0;
    initData();
    refreshController.refreshCompleted();
  }

  @override
  Future<void> functionSearch() async {
    rxList.value = await dbHelper.getTransactionsOfFund(
        fundID, 0, defaultItemOfPage,
        keySearch: textSearchController.text);
  }
}
