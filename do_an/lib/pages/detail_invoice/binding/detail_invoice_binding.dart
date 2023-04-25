import 'package:get/get.dart';
import '../controller/detail_invoice_controller.dart';

class DetailInvoiceBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<DetailInvoiceController>(() => DetailInvoiceController());
    }
}
