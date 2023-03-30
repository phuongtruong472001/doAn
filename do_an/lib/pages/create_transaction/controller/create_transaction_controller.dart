import 'package:do_an/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';

class CreateTransactionController extends GetxController {
  final valueController = TextEditingController().obs;
  final categoryController = TextEditingController().obs;
  final noteController = TextEditingController().obs;
  final dateTimeController = TextEditingController().obs;
  final fundController = TextEditingController().obs;
  final peopleController = TextEditingController().obs;
  Rx<Transaction> transaction = Transaction().obs;
  var choosedDate = false.obs;
  var selectedDate = DateTime.now().obs;

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
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  void chooseCategory() {
    Get.toNamed(AppRoutes.category)!.then((value) {
      transaction.update((val) {
        val!.categoryId = value.id;
      });
    });
  }

  void chooseFund() {
    Get.toNamed(AppRoutes.fund)!.then((value) {
      transaction.update((val) {
        if (value is int) {
          val!.fundID = value;
        }
      });
    });
  }
}
