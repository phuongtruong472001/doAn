import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/routes/routes.dart';
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
        title: Text(Get.arguments == null ? "Ví của tôi" : "Chọn nguồn tiền"),
        actions: [
          if (Get.arguments == null) ...[
            const Icon(Icons.notifications),
            const AutoSizeText("SỬA"),
          ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.createFund);
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Get.arguments == null)
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
            Obx(
              () => ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => controller.onTapItem(controller.funds[index]),
                  child: ListTile(
                    leading: const Icon(Icons.sports_basketball_rounded),
                    title: AutoSizeText(
                      controller.funds[index].name ?? "",
                    ),
                    subtitle: AutoSizeText(
                      controller.funds[index].value.toString(),
                    ),
                  ).paddingAll(paddingSmall),
                ),
                itemCount: controller.funds.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            )
          ],
        ).paddingSymmetric(
          horizontal: defaultPadding,
        ),
      ),
    );
  }
}
