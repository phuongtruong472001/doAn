import 'package:get/get.dart';
import '../controller/bottom_navigation_bar_home_controller.dart';

class BottomNavigationBarHomeBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<BottomNavigationBarHomeController>(() => BottomNavigationBarHomeController());
    }
}
