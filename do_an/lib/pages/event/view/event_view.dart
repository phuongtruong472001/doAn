import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/component/util_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base_ui/base_search_appbar_widget.dart';
import '../../../routes/routes.dart';
import '../controller/event_controller.dart';

class EventPage extends BaseSearchAppBarWidget<EventController> {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget buildWidgets() {
    return baseShimmerLoading(
      () => buildPage(
        backButton: true,
        showWidgetEmpty: false,
        buildBody: UtilWidget.buildSmartRefresher(
          refreshController: controller.refreshController,
          onRefresh: controller.onRefresh,
          onLoadMore: controller.onLoadMore,
          child: ListView.builder(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => controller.onTapItem(controller.rxList[index]),
              child: Card(
                child: ListTile(
                  title: AutoSizeText(
                    controller.rxList[index].name ?? "",
                  ),
                  trailing: Column(
                    children: [
                      AutoSizeText(DateFormat('kk:mm dd-MM-yyyy')
                          .format(controller.rxList[index].date)),
                      if (controller.rxList[index].allowNegative == 1) ...[
                        const AutoSizeText(
                          AppString.notComplete,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ] else ...[
                        const AutoSizeText(
                          AppString.complete,
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                    ],
                  ),
                  subtitle: AutoSizeText(
                    "Đã chi ${controller.rxList[index].value.toString().toVND()}/${controller.rxList[index].estimateValue.toString().toVND()} số tiền dự kiến",
                  ),
                ).paddingAll(paddingSmall),
              ),
            ),
            itemCount: controller.rxList.length,
          ),
        ),
        function: () {
          Get.toNamed(
            AppRoutes.createEvent,
          );
        },
      ),
    );
  }
}
