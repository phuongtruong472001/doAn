import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/icons.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';

import '../controller/fund_controller.dart';

class FundPage extends GetView<FundController> {
  const FundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: AutoSizeText(
            Get.arguments == null ? AppString.myFund : AppString.selectFund),
        actions: [
          if (Get.arguments == null) ...[
            const Icon(Icons.notifications),
            const AutoSizeText(AppString.edit),
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
                child: Card(
                  child: Obx(() => ListTile(
                        leading: const Icon(Icons.sports_basketball_rounded),
                        title: const AutoSizeText(AppString.total),
                        subtitle: AutoSizeText(
                          controller.totalValue.value
                              .toString()
                              .toVND(unit: 'đ'),
                        ),
                      )),
                ),
              ),
            const AutoSizeText(AppString.listFund),
            Obx(
              () => ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => controller.onTapItem(controller.funds[index]),
                  child: ListTile(
                    leading: Image.asset(ImageAsset.linkIconFund +
                        controller.funds[index].icon!),
                    title: AutoSizeText(
                      controller.funds[index].name ?? "",
                    ),
                    subtitle: AutoSizeText(
                      controller.funds[index].value.toString().toVND(unit: 'đ'),
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
