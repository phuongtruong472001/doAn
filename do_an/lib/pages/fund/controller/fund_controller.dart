import 'package:do_an/model/fund.dart';
import 'package:get/get.dart';

import '../../../database/database.dart';

class FundController extends GetxController {
  RxList<Fund> funds = List<Fund>.empty().obs;
  @override
  void onInit() async {
    await initData();
    super.onInit();
  }

  Future<void> initData() async {
    var dbHelper = DBHelper();
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
    Get.back(result: fund);
  }

  void createFund() {}
}
