import 'package:do_an/database/database.dart';
import 'package:do_an/model/event.dart';
import 'package:do_an/pages/bottom_navigation_bar_home/controller/bottom_navigation_bar_home_controller.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<Event> events = List<Event>.empty().obs;
  RxList<Event> allEvents = List<Event>.empty().obs;

  BottomNavigationBarHomeController bottomNavigationBarHomeController =
      Get.find();

  @override
  void onInit() async {
    await initData();
    super.onInit();
  }

  @override
  void onReady() {}

  Future<void> initData() async {
    DBHelper db = DBHelper();
    events.value = await db.getEventsOutOfDate();
    allEvents.value = await db.getAllEvents();
    bottomNavigationBarHomeController.numbEvent.value = events.length;
  }
}
