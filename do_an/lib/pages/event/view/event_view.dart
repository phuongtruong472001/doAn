import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        buildBody: ListView.builder(
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => controller.onTapItem(controller.rxList[index]),
            child: ListTile(
              leading: const Icon(Icons.sports_basketball_rounded),
              title: AutoSizeText(
                controller.rxList[index].name ?? "",
              ),
              subtitle: AutoSizeText(
                controller.rxList[index].estimateValue.toString(),
              ),
            ).paddingAll(paddingSmall),
          ),
          itemCount: controller.rxList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
        function: () {
          Get.toNamed(
            AppRoutes.createEvent,
            arguments: true,
          );
        },
      ),
    );
  }
}
