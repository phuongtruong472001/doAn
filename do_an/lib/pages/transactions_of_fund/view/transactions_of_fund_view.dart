import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/component/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/transactions_of_fund_controller.dart';

class TransactionsOfFundPage extends GetView<TransactionsOfFundController> {
  const TransactionsOfFundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Obx(
          () => AutoSizeText(
            controller.nameOfFund.value,
            style: Get.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) => TransactionWidget(
            controller.transactions[index],
          ),
          itemCount: controller.transactions.length,
        ),
      ),
    );
  }
}
