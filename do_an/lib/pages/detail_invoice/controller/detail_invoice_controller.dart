import 'package:do_an/model/invoice.dart';
import 'package:get/get.dart';

class DetailInvoiceController extends GetxController {
  Rx<Invoice> invoice = Invoice().obs;
  @override
  void onInit() {
    invoice.value = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {}
}
