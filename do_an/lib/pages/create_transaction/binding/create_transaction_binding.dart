import 'package:get/get.dart';
import '../controller/create_transaction_controller.dart';

class CreateTransactionBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<CreateTransactionController>(() => CreateTransactionController());
    }
}
