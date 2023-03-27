import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTransactionController extends GetxController {
  final valueController = TextEditingController().obs;
  final categoryController = TextEditingController().obs;
  final noteController = TextEditingController().obs;
  final dateTimeController = TextEditingController().obs;
  final fundController = TextEditingController().obs;
  final peopleController = TextEditingController().obs;
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
}
