import 'package:do_an/database/database.dart';
import 'package:do_an/model/event.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<Event> events = List<Event>.empty().obs;
  RxList<Event> allEvents = List<Event>.empty().obs;
  @override
  void onInit() async {
    await initData();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> initData() async {
    DBHelper db = DBHelper();
    events.value = await db.getEventsOutOfDate();
    allEvents.value = await db.getEvents();
  }
}
