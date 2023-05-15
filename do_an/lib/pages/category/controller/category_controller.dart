import 'package:do_an/model/category.dart';
import 'package:get/get.dart';

import '../../../base_controller/base_search_appbar_controller.dart';
import '../../../database/database.dart';

class CategoryController extends BaseSearchAppbarController {
  var dbHelper = DBHelper();
  @override
  void onInit() async {
    await initData();
    super.onInit();
  }

  Future<void> initData() async {
    List<Category> categories = await dbHelper.getCategories();
    rxList.value = categories;
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  void onTapItem(Category category) {
    Get.back(result: category);
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
    rxList.value = await dbHelper.getCategories(
        keySearch: textSearchController.text.trim());
  }
}
