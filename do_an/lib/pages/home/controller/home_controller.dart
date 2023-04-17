import 'package:do_an/database/database.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt totalValue = 0.obs;
  RxInt cashValue = 0.obs;
  DBHelper dbHelper = DBHelper();
  @override
  void onInit() async {
    await initData();
    super.onInit();
  }

  @override
  void onReady() {}

  Future<void> initData() async {
    totalValue.value = await dbHelper.getTotalValue("", "");
    cashValue.value = await dbHelper.getTotalValueOfCash();
  }
}
