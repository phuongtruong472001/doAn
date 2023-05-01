import 'package:do_an/database/database.dart';
import 'package:do_an/model/event.dart';
import 'package:do_an/pages/home/controller/home_controller.dart';
import 'package:do_an/pages/transaction/controller/transaction_controller.dart';
import 'package:get/get.dart';

import '../../notification/controller/notification_controller.dart';

class BottomNavigationBarHomeController extends GetxController {
  RxInt indexTab = 0.obs;
  late NotificationController notificationController;
  @override
  void onInit() {
    notificationController = Get.find<NotificationController>();
    super.onInit();
  }

  @override
  void onReady() {}

  void onTapped(int index) async {
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
        if (notificationController.events.isNotEmpty) {
          await updateData();
          await notificationController.initData();
        }
        break;
    }
  }

  Future<void> updateData() async {
    DBHelper dbHelper = DBHelper();
    for (Event event in notificationController.events) {
      await dbHelper.updateEventOutOfDate(event);
    }
  }
}
