import 'package:do_an/database/database.dart';
import 'package:do_an/model/event.dart';
import 'package:do_an/pages/event/controller/event_controller.dart';
import 'package:do_an/pages/home/controller/home_controller.dart';
import 'package:do_an/pages/transaction/controller/transaction_controller.dart';
import 'package:get/get.dart';

import '../../../base_controller/base_controller.dart';

class BottomNavigationBarHomeController extends BaseGetxController {
  RxInt indexTab = 0.obs;
  RxInt numbEvent = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  void onTapped(int index) async {
    switch (index) {
      case 0:
        if (Get.isRegistered<HomeController>()) {
          HomeController homeController = Get.find<HomeController>();
          showLoading();
          await homeController.initData();
          hideLoading();
        }
        break;
      case 1:
        if (Get.isRegistered<TransactionController>()) {
          TransactionController transactionController =
              Get.find<TransactionController>();
          transactionController.onInit();
        }
        break;
      case 2:
        DBHelper dbHelper = DBHelper();
        List<Event> events = await dbHelper.getEventsOutOfDate();
        for (Event event in events) {
          await dbHelper.updateEventOutOfDate(event);
        }
        break;
      case 3:
        EventController eventController = Get.isRegistered<EventController>()
            ? Get.find<EventController>()
            : Get.put(EventController());
        eventController.initData();
        break;
    }
  }
}
