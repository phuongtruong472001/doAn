import 'package:do_an/model/fund.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../database/database.dart';
import '../../../routes/routes.dart';

class FundController extends GetxController {
  RxList<Fund> funds = List<Fund>.empty().obs;
  RxInt totalValue = 0.obs;
  @override
  void onInit() async {
    await initData();
    super.onInit();
  }

  Future<void> initData() async {
    var dbHelper = DBHelper();
    totalValue.value = await dbHelper.getTotalValue("", "");
    List<Fund> listFunds = await dbHelper.getFunds();
    funds.value = listFunds;
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  void onTapItem(Fund fund) {
    if (Get.arguments != null) {
      Get.back(result: fund);
    } else {
      Get.toNamed(AppRoutes.transactionsOfFund, arguments: fund)!.then((value) => initData());
    }
  }

  void createFund() {}
}
