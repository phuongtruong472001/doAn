import 'package:do_an/base_controller/base_controller_src.dart';
import 'package:do_an/database/database.dart';
import 'package:do_an/model/transaction.dart';
import 'package:do_an/pages/transaction/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../base/strings.dart';
import '../../../component/base_bottomsheet.dart';
import '../../../model/repeat_time.dart';
import '../../../routes/routes.dart';

class CreateTransactionController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final valueController = MoneyMaskedTextController(
      thousandSeparator: '.', precision: 0, decimalSeparator: "");
  final descriptionController = TextEditingController();

  final peopleController = TextEditingController();
  Rx<Transaction> transaction = Transaction().obs;
  var choosedDate = false.obs;
  var selectedDate = DateTime.now().obs;
  DBHelper dbHelper = DBHelper();

  void selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    choosedDate.value = true;
    if (picked != null && picked != DateTime.now()) {
      selectedDate.value = picked;
    }
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onReady() {}

  void initData() {
    if (Get.arguments is Transaction) {
      Transaction tran = Get.arguments;
      valueController.text = tran.value.toString();
      descriptionController.text = tran.description!;
      transaction.value.categoryName = tran.categoryName;
      transaction.value.fundName = tran.fundName;
      selectedDate.value = tran.executionTime!;
      transaction.value = tran;
    }
  }

  void chooseCategory() {
    Get.toNamed(AppRoutes.category)!.then((value) {
      if (value != null) {
        transaction.update((val) {
          val!.categoryId = value.id;
          val.categoryName = value.name;
          val.isIncrease = value.typeCategory;
        });
      }
    });
  }

  void chooseFund() {
    Get.toNamed(AppRoutes.fund, arguments: true)!.then((value) {
      if (value != null) {
        transaction.update((val) {
          val!.fundID = value.id;
          val.fundName = value.name;
        });
      }
    });
  }

  void chooseEvent() {
    Get.toNamed(AppRoutes.event, arguments: true)!.then((value) {
      if (value != null) {
        transaction.update((val) {
          val!.eventId = value.id;
          val.eventName = value.name;
        });
      }
    });
  }

  Future<void> createTransaction() async {
    if (transaction.value.isIncrease == 5) {
      transaction.value.value =
          int.parse(valueController.value.text.replaceAll('.', ''));
    } else {
      transaction.value.value =
          int.parse(valueController.value.text.replaceAll('.', '')) * (-1);
    }
    transaction.value.executionTime = selectedDate.value;
    transaction.value.description = descriptionController.value.text;
    transaction.value.endTime = transaction.value.executionTime;
    if (transaction.value.typeRepeat == 1) {
      if (transaction.value.typeTime == 0) {
        transaction.value.endTime = Jiffy(transaction.value.endTime)
            .add(duration: const Duration(days: 1))
            .dateTime;
      } else if (transaction.value.typeTime == 1) {
        transaction.value.endTime =
            Jiffy(transaction.value.endTime).add(weeks: 1).dateTime;
      } else {
        transaction.value.endTime =
            Jiffy(transaction.value.endTime).add(months: 1).dateTime;
      }
    }

    if (formKey.currentState!.validate() &&
        transaction.value.categoryId! >= 0) {
      bool status;
      if (Get.arguments == null) {
        status = await dbHelper.addTransaction(transaction.value);
      } else {
        status = await dbHelper.editTransaction(transaction.value);
      }
      String messege = "";
      if (status) {
        if (Get.arguments == null) {
          messege = AppString.addSuccess("Giao dịch");
        } else {
          messege = AppString.editSuccess("Giao dịch");
        }
        TransactionController transactionController =
            Get.find<TransactionController>();
        await transactionController.initData();
        Get.back();
      } else {
        messege = AppString.fail;
      }
      showSnackBar(
        messege,
        backgroundColor: status ? Colors.green : Colors.red,
      );
    } else {
      showSnackBar(
        "Số tiền và danh mục không thể để trống",
        backgroundColor: Colors.red,
      );
    }
  }

  void selectDateRepeat(BuildContext context) {
    Get.bottomSheet(BottomSheetSelectTime()).then((value) {
      if (value is RepeatTime) {
        transaction.update((val) {
          val!.executionTime = Jiffy(value.dateTime)
              .add(
                hours: value.timeOfDay!.hour,
                minutes: value.timeOfDay!.minute,
              )
              .dateTime;
          val.typeRepeat = value.typeRepeat;
          val.typeTime = value.typeTime;
          val.isRepeat = true;
        });
      } else {
        Get.delete<BaseBottomSheetController>();
      }
    });
  }
}
