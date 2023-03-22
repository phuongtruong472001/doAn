import 'package:get/get.dart';

class TracsactionController extends GetxController {
  RxInt indexTabbar = 0.obs;
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

  void onTapped(int index) {
    indexTabbar.value = index;
  }
}
