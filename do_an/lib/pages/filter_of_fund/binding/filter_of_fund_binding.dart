import 'package:get/get.dart';
import '../controller/filter_of_fund_controller.dart';

class FilterOfFundBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<FilterOfFundController>(() => FilterOfFundController());
    }
}
