import 'package:do_an/model/fund.dart';
import 'package:get/get.dart';

class FundController extends GetxController {
  RxList<Fund> fund = List<Fund>.empty().obs;
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

  void onTapItem(Fund fund) {
    Get.back(result: fund);
  }
}
