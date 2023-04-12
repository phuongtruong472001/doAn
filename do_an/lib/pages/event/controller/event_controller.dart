import 'package:get/get.dart';

import '../../../model/event.dart';

class EventController extends GetxController {
  RxList<Event> listEvents = List<Event>.empty(growable: true).obs;
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

  void onTapItem(Event event) {
    Get.back(result: event);
  }
}
