import 'package:do_an/component/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base_ui/base_search_appbar_widget.dart';
import '../../../component/util_widget.dart';
import '../controller/transactions_of_fund_controller.dart';

class TransactionsOfFundPage
    extends BaseSearchAppBarWidget<TransactionsOfFundController> {
  const TransactionsOfFundPage({Key? key}) : super(key: key);

  @override
  Widget buildWidgets() {
    return baseShimmerLoading(
      () => buildPage(
        hintSearch: "Tìm kiếm trong ${controller.nameOfFund}",
        backButton: true,
        showWidgetEmpty: false,
        buildBody: UtilWidget.buildSmartRefresher(
          refreshController: controller.refreshController,
          onRefresh: controller.onRefresh,
          onLoadMore: controller.onLoadMore,
          child: Obx(
            () => ListView.builder(
              itemBuilder: (context, index) => TransactionWidget(
                controller.rxList[index],
              ),
              itemCount: controller.rxList.length,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ),
      ),
    );
  }
}
