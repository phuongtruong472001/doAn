import 'package:get/get.dart';
import '../controller/transactions_of_fund_controller.dart';

class TransactionsOfFundBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<TransactionsOfFundController>(() => TransactionsOfFundController());
    }
}
