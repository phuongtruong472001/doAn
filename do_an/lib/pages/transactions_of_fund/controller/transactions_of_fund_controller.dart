import 'package:do_an/model/fund.dart';
import 'package:get/get.dart';

import '../../../base_controller/base_search_appbar_controller.dart';
import '../../../database/database.dart';

class TransactionsOfFundController extends BaseSearchAppbarController {
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
    rxList.value = await dbHelper.getTransactionsOfFund(
      "",
      "",
      fund.id ?? 0,
    );
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
    rxList.value = await dbHelper.getTransactionsOfFund("", "", 0,
        keySearch: textSearchController.text);
  }
}
