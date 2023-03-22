import 'package:get/get.dart';
import '../controller/transaction_controller.dart';

class BottomNavigationBarHomeBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<TracsactionController>(() => TracsactionController());
    }
}
