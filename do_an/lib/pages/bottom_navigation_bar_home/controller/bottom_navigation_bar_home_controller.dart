import 'package:get/get.dart';

class BottomNavigationBarHomeController extends GetxController {
  RxInt indexTab = 0.obs;
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
    indexTab.value = index;
  }
}
