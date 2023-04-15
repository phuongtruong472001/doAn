import 'package:get/get.dart';

import '../../../database/database.dart';
import '../../../model/event.dart';

class EventController extends GetxController {
  RxList<Event> listEvents = List<Event>.empty(growable: true).obs;
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

  void onTapItem(Event event) {
    Get.back(result: event);
  }

  Future<void> initData() async {
    var dbHelper = DBHelper();
    List<Event> events = await dbHelper.getEvents();
    listEvents.value = events;
  }
}
