import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/invoice_controller.dart';

class InvoicePage extends GetView<InvoiceController> {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(AppString.myInvoice),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.createInvoice);
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: TabBar(
              controller: controller.tabController,
              labelColor: Colors.blue,
              labelStyle: const TextStyle(color: Colors.blue),
              unselectedLabelStyle: const TextStyle(color: Colors.black),
              unselectedLabelColor: Colors.black,
              tabs: const <Widget>[
                Tab(
                  child: Text("Đang diễn ra"),
                ),
                Tab(
                  child: Text("Đã kết thúc"),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: const <Widget>[
                Center(
                  child: Text("It's cloudy here"),
                ),
                Center(
                  child: Text("It's cloudy here"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
