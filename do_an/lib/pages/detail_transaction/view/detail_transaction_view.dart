import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/detail_transaction_controller.dart';

class DetailTransactionPage extends GetView<DetailTransactionController> {
  const DetailTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.cancel,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildItem(Icons.apple, "Ăn uống"),
          _buildItem(Icons.calendar_month, "Thời gian"),
          _buildItem(Icons.badge, "Tiền mặt"),
          _buildItem(Icons.event, "sự kiện"),
        ],
      ),
    );
  }

  _buildItem(IconData iconData, String title) {
    return ListTile(
      leading: Icon(iconData),
      title: AutoSizeText(
        title,
      ),
    );
  }
}
