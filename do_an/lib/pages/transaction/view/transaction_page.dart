import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/base_ui/base_ui_src.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/item_card.dart';
import '../../../component/util_widget.dart';
import '../controller/transaction_controller.dart';

class TracsactionPage extends BaseSearchAppBarWidget<TransactionController> {
  const TracsactionPage({Key? key}) : super(key: key);

  @override
  Widget buildWidgets() {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: baseShimmerLoading(
        () => buildPage(
          backButton: false,
          showWidgetEmpty: false,
          buildBody: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: TabBar(
                          tabs: const [
                            AutoSizeText(AppString.lastMonth),
                            AutoSizeText(AppString.thisMonth),
                            AutoSizeText(AppString.future),
                          ],
                          onTap: (value) => controller.onTapped(value),
                          labelColor: kPrimaryColor,
                          unselectedLabelColor: kSecondaryColor,
                        ),
                      )
                    ],
                  )),
              Expanded(
                child: UtilWidget.buildSmartRefresher(
                  refreshController: controller.refreshController,
                  onRefresh: controller.onRefresh,
                  onLoadMore: controller.onLoadMore,
                  enablePullUp: true,
                  child: ListView.builder(
                    controller: controller.scrollControllerUpToTop,
                    padding: EdgeInsets.only(
                      top: controller.isScrollToTop() ? 0 : 70,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () =>
                            controller.goToDetail(controller.rxList[index]),
                        child: TransactionWidget(
                          controller.rxList[index],
                        ),
                      );
                    },
                    itemCount: controller.rxList.length,
                  ),
                ),
              )
            ],
          ).paddingAll(paddingSmall),
        ),
      ),
    );
  }

  Widget moneyOfDate(String thu, int day, int month, int year, String money) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 1.0, color: Color.fromARGB(128, 0, 0, 0)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.all(5),
                    child: Text(
                      '$day',
                      style: const TextStyle(fontSize: 40),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(thu),
                    Text(
                      'tháng $month $year',
                      style: const TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 113, 113, 113)),
                    )
                  ],
                )
              ]),
          Text(
            money,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
