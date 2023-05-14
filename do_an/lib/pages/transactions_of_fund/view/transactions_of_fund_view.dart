import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/component/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../base/colors.dart';
import '../../../base/dimen.dart';
import '../../../base_ui/base_search_appbar_widget.dart';
import '../../../component/util_widget.dart';
import '../controller/transactions_of_fund_controller.dart';

class TransactionsOfFundPage
    extends BaseSearchAppBarWidget<TransactionsOfFundController> {
  const TransactionsOfFundPage({Key? key}) : super(key: key);

  @override
  Widget buildWidgets() {
    return Scaffold(
      body: baseShimmerLoading(
        () => buildPage(
          hintSearch: "Tìm kiếm giao dịch trong ${controller.nameOfFund}",
          backButton: true,
          showWidgetEmpty: true,
          actionExtra: Obx(
            () => Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    const Icon(
                      Icons.filter_alt_outlined,
                      color: kPrimaryColor,
                    ),
                    if (controller.isFilter.value)
                      const Positioned(
                        top: 10,
                        right: -3.0,
                        child: Icon(
                          Icons.check_circle,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      )
                  ],
                ),
                onPressed: controller.showFilterPage,
              ),
            ).paddingOnly(
              left: paddingSmall,
            ),
          ),
          buildBody: Column(
            children: [
              Obx(
                () => Visibility(
                  visible: controller.isFilter.value,
                  child: Row(
                    children: [
                      Expanded(
                          child: AutoSizeText(
                        " ${controller.fromDate} -> ${controller.toDate}",
                        style: Get.textTheme.bodyLarge!
                            .copyWith(fontStyle: FontStyle.italic),
                      )),
                      IconButton(
                          onPressed: () async {
                            controller.isFilter.value = false;
                            await controller.initData();
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: UtilWidget.buildSmartRefresher(
                  refreshController: controller.refreshController,
                  onRefresh: controller.onRefresh,
                  onLoadMore: controller.onLoadMore,
                  enablePullUp: true,
                  child: Obx(
                    () => GroupedListView<dynamic, String>(
                      shrinkWrap: true,
                      elements: controller.rxList.value,
                      useStickyGroupSeparators: true,
                      controller: controller.scrollControllerUpToTop,
                      groupBy: (dynamic element) => DateFormat('yyyy-MM-dd')
                          .format(element.executionTime),
                      groupSeparatorBuilder: (String value) {
                        return Container(
                          color: Color.fromARGB(255, 243, 240, 240),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      child: Text(
                                        DateFormat.d("vi").format(
                                          DateTime.parse(value),
                                        ),
                                        style:
                                            Get.textTheme.bodyText1!.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: Column(
                                        children: [
                                          Text(
                                            DateFormat.EEEE("vi").format(
                                              DateTime.parse(value),
                                            ),
                                          ),
                                          Text(
                                            DateFormat.yM("vi").format(
                                              DateTime.parse(value),
                                            ),
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 121, 120, 120)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "+" +
                                          (controller.listThu[value] != null
                                              ? controller.listThu[value]
                                                  .toString()
                                                  .toVND()
                                              : "0 đ"),
                                      style: Get.textTheme.bodyText1!.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      controller.listChi[value] != null
                                          ? controller.listChi[value]
                                              .toString()
                                              .toVND()
                                          : "0 đ",
                                      style: Get.textTheme.bodyText1!.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemBuilder: (context, dynamic element) => Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              flex: 1,
                              onPressed: (context) {
                                // controller.deleteTransaction(element);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Xóa',
                            ),
                          ],
                        ),
                        child: TransactionWidget(element),
                      ),
                      order: GroupedListOrder.DESC,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
