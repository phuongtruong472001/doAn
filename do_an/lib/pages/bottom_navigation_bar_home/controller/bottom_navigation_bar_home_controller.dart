import 'package:do_an/database/database.dart';
import 'package:do_an/model/event.dart';
import 'package:do_an/pages/event/controller/event_controller.dart';
import 'package:do_an/pages/home/controller/home_controller.dart';
import 'package:do_an/pages/transaction/controller/transaction_controller.dart';
import 'package:get/get.dart';

import '../../../base_controller/base_controller.dart';
import '../../notification/controller/notification_controller.dart';

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
    // switch (index) {
    //   case 0:
    //     HomeController homeController = Get.find<HomeController>();
    //     showLoading();
    //     await homeController.initData();
    //     hideLoading();
    //     break;
    //   case 1:
    //     TransactionController transactionController =
    //         Get.find<TransactionController>();
    //     transactionController.onInit();
    //     break;
    //   case 2:
    //     NotificationController notificationController =
    //         Get.find<NotificationController>();
    //     if (notificationController.events.isNotEmpty) {
    //       await updateData(notificationController);
    //       await notificationController.initData();
    //     }
    //     break;
    // }

    if (index == 2) {
      DBHelper dbHelper = DBHelper();
      List<Event> events = await dbHelper.getEventsOutOfDate();
      for (Event event in events) {
        await dbHelper.updateEventOutOfDate(event);
      }
    }
    if (index == 3) {
      EventController eventController = Get.find<EventController>();
      eventController.initData();
    }
  }
}
