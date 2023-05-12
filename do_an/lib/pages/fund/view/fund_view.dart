import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/icons.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';

import '../../../component/base_appbar.dart';
import '../controller/fund_controller.dart';

class FundPage extends GetView<FundController> {
  const FundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: Get.arguments == null ? AppString.myFund : AppString.selectFund,
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
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      AppString.total,
                      style: Get.textTheme.bodyLarge!.copyWith(fontSize: 20),
                    ),
                    Obx(
                      () => AutoSizeText(
                        controller.totalValue.value.toString().toVND(unit: 'đ'),
                        style: Get.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: controller.totalValue.value >= 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    )
                  ],
                ).marginOnly(top: defaultPadding),
              ),
            const AutoSizeText(AppString.listFund)
                .paddingSymmetric(vertical: paddingSmall),
            Obx(
              () => ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => controller.onTapItem(controller.funds[index]),
                  child: Card(
                    child: ListTile(
                      leading: Image.asset(
                        ImageAsset.linkIconFund + controller.funds[index].icon!,
                        width: 40,
                        height: 40,
                      ),
                      title: AutoSizeText(
                        controller.funds[index].name ?? "",
                      ),
                      subtitle: AutoSizeText(
                        controller.funds[index].value
                            .toString()
                            .toVND(unit: 'đ'),
                        style: Get.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: controller.funds[index].value! >= 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_down_outlined),
                    ),
                  ).paddingOnly(bottom: paddingSmall),
                ),
                itemCount: controller.funds.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            )
          ],
        ).marginSymmetric(
          horizontal: defaultPadding,
        ),
      ),
    );
  }
}
