import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/base_ui/base_ui_src.dart';
import 'package:do_an/component/divider.dart';
import 'package:do_an/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';

import '../../../component/base_appbar.dart';
import '../../../component/base_card.dart';
import '../../../component/base_header_no_backbutton.dart';
import '../../../component/chart.dart';
import '../../../component/item_card.dart';
import '../../../component/space_bettwen_texts.dart';
import '../controller/home_controller.dart';

class HomePage extends BaseGetWidget<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomeController get controller => Get.put(HomeController());

  @override
  Widget buildWidgets() {
    return baseShowLoading(
      () => Scaffold(
        appBar: WidgetAppBar(
          title: 'Xin chào, ${controller.box.read("name")}',
          isCenterTitle: false,
          backButton: false,
          menuItem: [
            IconButton(
              onPressed: () {
                controller.box.remove("name");
                Get.offAllNamed(AppRoutes.editName);
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.fund),
                child: Card(
                  child: Column(
                    children: [
                      const SpaceBetweenLetter(
                        title: AppString.myWallet,
                        subTitle: AppString.viewAll,
                      ).paddingAll(paddingSmall),
                      BuildDividerDefault(),
                      Obx(
                        () => ListTile(
                          leading: Icon(Icons.wallet),
                          title: AutoSizeText(
                            AppString.cash,
                            style: Get.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: AutoSizeText(
                            controller.cashValue.value
                                .toString()
                                .toVND(unit: 'đ'),
                            style: Get.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SpaceBetweenLetter(
                title: AppString.spendingReport,
                subTitle: AppString.viewReport,
              ).paddingSymmetric(vertical: paddingSmall),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BarChar(
                      spending: controller.spedings,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          color: Colors.green,
                        ),
                        AutoSizeText("  Đã thu    "),
                        Container(
                          width: 15,
                          height: 15,
                          color: Colors.red,
                        ),
                        AutoSizeText("  Đã chi "),
                      ],
                    ).marginOnly(bottom: 8),
                  ],
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
    );
  }
}
