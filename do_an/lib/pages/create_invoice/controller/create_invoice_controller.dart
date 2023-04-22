import 'package:do_an/model/invoice.dart';
import 'package:do_an/model/repeat_time.dart';
import 'package:flutter/material.dart';
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
  var time = const TimeOfDay(hour: 7, minute: 15).obs;

  void selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time.value,
    );
    if (newTime != null) {
      time.value = newTime;
    }
  }

  @override
  void onReady() {}

  void createInvoice() async {
    invoice.value.value = int.parse(valueController.text);
    invoice.value.description = descriptionController.text;
    bool status = await dbHelper.addInvoice(invoice.value);
    if (status) {
      print("thêm hoá đơn thành công");
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
      Get.delete<BaseBottomSheetController>();

      if (value is RepeatTime) {
        invoice.update((val) {
          val!.executionTime = value.dateTime;
          val.nameRepeat = value.nameRepeat;
          val.typeRepeat = val.typeRepeat;
          val.typeTime = val.typeTime;
        });
      }
    });
  }
}
