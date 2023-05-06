import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/base_ui/base_ui_src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
          // actionExtra: Obx(
          //   () => Container(
          //     height: 40,
          //     width: 40,
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       shape: BoxShape.circle,
          //     ),
          //     child: IconButton(
          //       icon: Stack(
          //         clipBehavior: Clip.none,
          //         children: <Widget>[
          //           const Icon(
          //             Icons.filter_alt_outlined,
          //             color: kPrimaryColor,
          //           ),
          //           if (controller.isFilter.value)
          //             const Positioned(
          //               top: 10,
          //               right: -3.0,
          //               child: Icon(
          //                 Icons.check_circle,
          //                 size: 12,
          //                 color: kPrimaryColor,
          //               ),
          //             )
          //         ],
          //       ),
          //       onPressed: controller.showFilterPage,
          //     ),
          //   ).paddingOnly(
          //     left: paddingSmall,
          //   ),
          // ),
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
                      return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.
                              flex: 1,
                              onPressed: (context) {
                                controller.deleteTransaction(
                                    controller.rxList[index]);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Xóa',
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              controller.goToDetail(controller.rxList[index]),
                          child: TransactionWidget(
                            controller.rxList[index],
                          ),
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
}
