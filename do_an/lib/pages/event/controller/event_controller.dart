import 'package:do_an/routes/routes.dart';
import 'package:get/get.dart';

import '../../../base_controller/base_search_appbar_controller.dart';
import '../../../database/database.dart';
import '../../../model/event.dart';

class EventController extends BaseSearchAppbarController {
  var dbHelper = DBHelper();
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
    if (Get.arguments) {
      Get.back(result: event);
    } else {
      Get.toNamed(AppRoutes.createEvent, arguments: event);
    }
  }

  Future<void> initData() async {
    List<Event> events = await dbHelper.getEvents();
    rxList.value = events;
  }

  @override
  Future<void> onLoadMore() async {
    refreshController.loadComplete();
  }

  @override
  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
  }

  @override
  Future<void> functionSearch() async {
    rxList.value =
        await dbHelper.getEvents(keySearch: textSearchController.text);
  }
}
