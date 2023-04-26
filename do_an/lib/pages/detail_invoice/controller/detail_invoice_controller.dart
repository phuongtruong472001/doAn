import 'package:do_an/model/transaction.dart';
import 'package:get/get.dart';

class DetailInvoiceController extends GetxController {
  Rx<Transaction> transaction = Transaction().obs;
  @override
  void onInit() {
    transaction.value = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }
}
