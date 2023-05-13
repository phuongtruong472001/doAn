import 'package:do_an/pages/transactions_of_fund/controller/transactions_of_fund_controller.dart';
import 'package:get/get.dart';

class FilterOfFundController extends GetxController {
  late RxString fromDateStr;
  late RxString toDateStr;
  TransactionsOfFundController transactionController =
      Get.find<TransactionsOfFundController>();

  @override
  void onInit() {
    fromDateStr = transactionController.fromDate.obs;
    toDateStr = transactionController.toDate.obs;
    super.onInit();
  }
}
