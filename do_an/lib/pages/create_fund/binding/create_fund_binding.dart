import 'package:get/get.dart';
import '../controller/create_fund_controller.dart';

class CreateFundBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<CreateFundController>(() => CreateFundController());
    }
}
