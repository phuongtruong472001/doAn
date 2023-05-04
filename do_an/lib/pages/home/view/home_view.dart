import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/base_ui/base_ui_src.dart';
import 'package:do_an/component/divider.dart';
import 'package:do_an/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../component/base_card.dart';
import '../../../component/base_header_no_backbutton.dart';
import '../../../component/chart.dart';
import '../../../component/item_card.dart';
import '../../../component/space_bettwen_texts.dart';
import '../controller/home_controller.dart';

class HomePage extends BaseGetWidget<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget buildWidgets() {
    return baseShowLoading(
      () => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BaseHeaderNoBackButton(
                  content: 'Hello ${controller.box.read("name")}',
                  icon: Icons.logout,
                  title: 'Good Morning',
                  function: () {
                    controller.box.remove("name");
                    Get.offAllNamed(AppRoutes.editName);
                  },
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
                          AppString.total,
                          subTitle: controller.totalValue.value
                              .toString()
                              .toVND(unit: 'đ'),
                        ),
                      ),
                      Obx(
                        () => ItemCard(
                          Icons.wallet,
                          AppString.cash,
                          subTitle: controller.cashValue.value
                              .toString()
                              .toVND(unit: 'đ'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SpaceBetweenLetter(
                  title: AppString.spendingReport,
                  subTitle: AppString.viewReport,
                ).paddingSymmetric(vertical: paddingSmall),
                Card(
                  child: BarChar(
                    spending: controller.spedings,
                  ),
                ),
                const SpaceBetweenLetter(
                  title: AppString.recentTransactions,
                  subTitle: "",
                ).paddingSymmetric(vertical: paddingSmall),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TransactionWidget(
                      controller.rxList[index],
                    );
                  },
                  itemCount: controller.rxList.length,
                ),
              ],
            ).paddingAll(defaultPadding),
          ),
        ),
      ),
    );
  }
}
