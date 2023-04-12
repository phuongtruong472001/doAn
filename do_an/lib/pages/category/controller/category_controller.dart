import 'dart:ffi';

import 'package:do_an/model/category.dart';
import 'package:get/get.dart';

import '../../../database/database.dart';

class CategoryController extends GetxController {
  RxList<Category> listCategories = List<Category>.empty().obs;
  @override
  void onInit() async {
    await initData();
    super.onInit();
  }

  Future<void> initData() async {
    var dbHelper = DBHelper();
    List<Category> categories = await dbHelper.getCategories();
    listCategories.value = categories;
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
}
