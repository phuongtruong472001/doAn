import 'package:do_an/model/transaction.dart';
import 'package:do_an/pages/home/controller/home_controller.dart';
import 'package:do_an/pages/transaction/controller/transaction_controller.dart';
import 'package:get/get.dart';

class BottomNavigationBarHomeController extends GetxController {
  RxInt indexTab = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  void onTapped(int index) {
    indexTab.value = index;
    switch (index) {
      case 0:
        HomeController homeController = Get.find<HomeController>();
        homeController.initData();
        break;
      case 1:
        TransactionController transactionController =
            Get.find<TransactionController>();
        transactionController.initData();
        break;
      case 2:
        break;
    }
  }
}
