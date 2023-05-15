import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/base_ui/base_ui_src.dart';
import 'package:do_an/component/divider.dart';
import 'package:do_an/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';

import '../../../base/colors.dart';
import '../../../component/base_appbar.dart';
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
                onTap: () => Get.toNamed(AppRoutes.fund)!.then((value) => controller.initData()),
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
                            AppString.total,
                            style: Get.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: AutoSizeText(
                            controller.totalValue.value
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    AppString.spendingReport,
                  ),
                 
                  DropdownButton<String>(
                    value: controller.listFund[controller.fundID.value + 1],
                    elevation: 16,
                    style: const TextStyle(color: Colors.green),
                    underline: Container(),
                    onChanged: (String? value) async {
                     await controller.changeFund(value);
                    },
                    items: controller.listFund
                        .map<DropdownMenuItem<String>>((element) {
                      return DropdownMenuItem<String>(
                        value: element,
                        child: AutoSizeText(element),
                      );
                    }).toList(),
                  ),
                ],
              ).paddingSymmetric(vertical: paddingSmall),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => BarChar(
                          spending: controller.spedings.value,
                        )),
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
              Card(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TransactionWidget(
                      controller.rxList[index],
                    );
                  },
                  itemCount: controller.rxList.length,
                ).paddingAll(8),
              ),
            ],
          ).paddingAll(defaultPadding),
        ),
      ),
    );
  }
}
