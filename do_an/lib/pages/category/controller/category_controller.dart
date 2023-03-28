import 'package:do_an/model/category.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
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

  void onTapItem(Category category) {
    Get.back(result: category);
  }
}
