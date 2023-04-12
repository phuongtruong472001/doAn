import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/fund_controller.dart';

class FundPage extends GetView<FundController> {
  const FundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Ví của tôi"),
        actions: const [Icon(Icons.notifications), AutoSizeText("SỬA")],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.sports_basketball_rounded),
                  title: AutoSizeText("Tổng cộng"),
                  subtitle: AutoSizeText("2000000 đ"),
                ),
              ),
            ),
            const AutoSizeText("Danh sách ví của bạn"),
            ListView.builder(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => controller.onTapItem(controller.fund[index]),
                child: const ListTile(
                  leading: Icon(Icons.sports_basketball_rounded),
                  title: AutoSizeText("Tiền mặt"),
                  subtitle: AutoSizeText("2000000 đ"),
                ).paddingAll(paddingSmall),
              ),
              itemCount: controller.fund.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            )
          ],
        ),
      ),
    );
  }
}
