import 'package:do_an/base_controller/base_controller.dart';
import 'package:do_an/model/invoice.dart';
import 'package:do_an/model/repeat_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

import '../../../component/base_bottomsheet.dart';
import '../../../database/database.dart';
import '../../../routes/routes.dart';

class CreateInvoiceController extends GetxController {
  final formData = GlobalKey<FormState>();
  final valueController = MoneyMaskedTextController(
      thousandSeparator: '.', precision: 0, decimalSeparator: "");
  final descriptionController = TextEditingController();
  Rx<Invoice> invoice = Invoice().obs;
  final peopleController = TextEditingController();
  var choosedDate = false.obs;
  var selectedDate = DateTime.now().obs;
  DBHelper dbHelper = DBHelper();

  @override
  void onReady() {}

  void createInvoice() async {
    invoice.value.value = int.parse(valueController.text.replaceAll('.', ''));
    invoice.value.description = descriptionController.text;
    if (invoice.value.categoryID! >= 0) {
      bool status = await dbHelper.addInvoice(invoice.value);
      if (status) {
        showSnackBar("thêm hoá đơn thành công", backgroundColor: Colors.green);
      }
    }
  }

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
    Get.bottomSheet(BottomSheetSelectTime()).then((value) {
      if (value is RepeatTime) {
        invoice.update((val) {
          val!.executionTime = value.dateTime;
          val.nameRepeat = value.nameRepeat;
          val.typeRepeat = value.typeRepeat;
          val.typeTime = value.typeTime;
          val.timeOfDay = value.timeOfDay;
        });
      } else {
        Get.delete<BaseBottomSheetController>();
      }
    });
  }
}
