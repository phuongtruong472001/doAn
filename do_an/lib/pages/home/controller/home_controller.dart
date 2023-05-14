import 'package:do_an/base_controller/base_controller.dart';
import 'package:do_an/database/database.dart';
import 'package:do_an/model/spending.dart';
import 'package:do_an/model/transaction.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/fund.dart';

class HomeController extends BaseGetxController {
  RxInt totalValue = 0.obs;
  RxInt cashValue = 0.obs;
  DBHelper dbHelper = DBHelper();
  RxList<Spending> spedings = RxList<Spending>.empty();
  final box = GetStorage();
  RxList<Transaction> rxList = RxList<Transaction>();
  RxInt fundID = (-1).obs;
  RxList<String> listFund = ["Tất cả"].obs;
  @override
  void onInit() async {
    await initData();
    super.onInit();
  }

  @override
  void onReady() {}

  Future<void> initData() async {
    showLoading();
    await dbHelper.autoGenerateTransaction();
    totalValue.value = await dbHelper.getTotalValue("", "");
    cashValue.value = await dbHelper.getTotalValueOfCash();
    rxList.value = await dbHelper.getTop5Recent();
    spedings.value = await getValueOfMonth();
    List<Fund> funds = await dbHelper.getFunds();
    for (Fund fund in funds) {
      if (listFund.length == 1) listFund.add(fund.name ?? "");
    }
    hideLoading();
  }

  Future<List<Spending>> getValueOfMonth() async {
    int month = DateTime.now().month;
    List<Spending> spendingTemp = [];
    for (int i = 1; i <= month; i++) {
      int pepper = await dbHelper.getTransactionsByMonth(i, 1, fundID.value);
      int receive = await dbHelper.getTransactionsByMonth(i, 0, fundID.value);
      spendingTemp.add(
        Spending(
          dateTime: DateTime(DateTime.now().year, i),
          pepper: pepper,
          receive: receive * (-1),
        ),
      );
    }
    return spendingTemp;
  }

  Future<void> changeFund(String? value) async {
    showLoading();
    fundID.value = listFund.indexOf(value ?? '') - 1;
    spedings.value = await getValueOfMonth().whenComplete(() => hideLoading());
    print(fundID.value);
  }
}
