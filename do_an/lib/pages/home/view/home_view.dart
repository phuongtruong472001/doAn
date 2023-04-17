import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/component/divider.dart';
import 'package:do_an/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/base_card.dart';
import '../../../component/base_header_no_backbutton.dart';
import '../../../component/item_card.dart';
import '../../../component/space_bettwen_texts.dart';
import '../controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const BaseHeaderNoBackButton(
                content: 'Hello Truong Phuong',
                icon: Icons.settings,
                title: 'Good Morning',
              ).paddingSymmetric(vertical: paddingSmall),
              CardBase(
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.fund),
                      child: const SpaceBetweenLetter(
                        title: AppString.myWallet,
                        subTitle: AppString.viewAll,
                      ).paddingAll(defaultPadding),
                    ),
                    BuildDividerDefault(),
                    Obx(
                      () => ItemCard(
                        Icons.wallet,
                        "Tổng cộng",
                        subTitle: controller.totalValue.value.toString(),
                      ),
                    ),
                    Obx(
                      () => ItemCard(
                        Icons.wallet,
                        "Tiền mặt",
                        subTitle: controller.cashValue.value.toString(),
                      ),
                    ),
                  ],
                ),
              ),
              const SpaceBetweenLetter(
                title: AppString.spendingReport,
                subTitle: AppString.viewReport,
              ).paddingSymmetric(vertical: paddingSmall),
            ],
          ).paddingAll(defaultPadding),
        ),
      ),
    );
  }
}
