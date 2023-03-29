import 'package:get/get.dart';
import '../controller/fund_controller.dart';

class FundBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<FundController>(() => FundController());
    }
}
