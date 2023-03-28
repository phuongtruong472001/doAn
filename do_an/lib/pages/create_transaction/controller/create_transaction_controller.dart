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
}
