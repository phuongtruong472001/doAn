import 'package:get/get.dart';
import '../controller/add_name_controller.dart';

class AddNameBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<AddNameController>(() => AddNameController());
    }
}
