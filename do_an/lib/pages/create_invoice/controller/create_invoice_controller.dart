import 'package:do_an/model/invoice.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../component/base_bottomsheet.dart';
import '../../../database/database.dart';
import '../../../routes/routes.dart';

class CreateInvoiceController extends GetxController {
  final valueController = TextEditingController();
  final descriptionController = TextEditingController();
  Rx<Invoice> invoice = Invoice().obs;
  final peopleController = TextEditingController();
  var choosedDate = false.obs;
  var selectedDate = DateTime.now().obs;
  DBHelper dbHelper = DBHelper();

  @override
  void onReady() {}

  void createInvoice() {}

  void chooseCategory() async {
    Get.toNamed(AppRoutes.category)!.then((value) {
      if (value != null) {
        invoice.update((val) {
          val!.categoryID = value.id;
          val.categoryName = value.name;
        });
      }
    });
  }

  void chooseFund() {
    Get.toNamed(AppRoutes.fund, arguments: true)!.then((value) {
      if (value != null) {
        invoice.update((val) {
          val!.fundId = value.id;
          val.fundName = value.name;
        });
      }
    });
  }

  void selectDate(BuildContext context) {
    Get.bottomSheet(const BottomSheetSelectTime());
  }
}
