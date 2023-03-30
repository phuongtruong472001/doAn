import 'package:get/get.dart';

class FundController extends GetxController {
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

  void onTapItem(int index) {
    Get.back(result: index);
  }
}
