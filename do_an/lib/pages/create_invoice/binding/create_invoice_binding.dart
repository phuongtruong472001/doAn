import 'package:get/get.dart';
import '../controller/create_invoice_controller.dart';

class CreateInvoiceBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<CreateInvoiceController>(() => CreateInvoiceController());
    }
}
