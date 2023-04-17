import 'package:do_an/database/database.dart';
import 'package:do_an/model/transaction.dart';
import 'package:do_an/pages/transaction/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/strings.dart';
import '../../../routes/routes.dart';

class CreateTransactionController extends GetxController {
  final valueController = TextEditingController();
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
      firstDate: DateTime.now(),
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
      transaction.value.value = int.parse(valueController.value.text);
    } else {
      transaction.value.value = int.parse(valueController.value.text) * (-1);
    }

    transaction.value.description = descriptionController.value.text;
    transaction.value.executionTime = selectedDate.value;
    bool status = await dbHelper.addTransaction(transaction.value);
    if (status) {
      TransactionController transactionController =
          Get.find<TransactionController>();
      await transactionController.initData();
      Get.back();
    }
    Get.snackbar(
      "",
      status ? AppString.success("Giao dịch") : AppString.fail,
      backgroundColor: status ? Colors.green : Colors.red,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
