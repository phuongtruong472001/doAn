import 'package:do_an/base_controller/base_controller.dart';
import 'package:do_an/database/database.dart';
import 'package:do_an/model/spending.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends BaseGetxController {
  RxInt totalValue = 0.obs;
  RxInt cashValue = 0.obs;
  DBHelper dbHelper = DBHelper();
  RxList<Spending> spedings = RxList<Spending>.empty();
  @override
  void onInit() async {
    showLoading();
    await initData();
    hideLoading();
    super.onInit();
  }

  @override
  void onReady() {}

  Future<void> initData() async {
    await dbHelper.autoGenerateTransaction();
    totalValue.value = await dbHelper.getTotalValue("", "");
    cashValue.value = await dbHelper.getTotalValueOfCash();
    spedings.value = await getValueOfMonth();
  }

  Future<List<Spending>> getValueOfMonth() async {
    int month = DateTime.now().month;
    List<Spending> spendingTemp = [];
    for (int i = 1; i <= month; i++) {
      int pepper = await dbHelper.getTransactionsByMonth(i, 1);
      int receive = await dbHelper.getTransactionsByMonth(i, 0);
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
}
