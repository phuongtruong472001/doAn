import 'package:do_an/model/invoice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../database/database.dart';

class InvoiceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxList<Invoice> listInvoices = List<Invoice>.empty().obs;
  RxList<Invoice> listInvoicesNotComplete = List<Invoice>.empty().obs;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    initData();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> initData() async {
    var dbHelper = DBHelper();
    listInvoices.value = await dbHelper.getInvoices(1);
    listInvoicesNotComplete.value = await dbHelper.getInvoices(0);
  }
}
