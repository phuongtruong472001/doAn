import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/component/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/strings.dart';
import '../../../component/base_appbar.dart';
import '../controller/notification_controller.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  NotificationController get controller => Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: Get.arguments == null
            ? AppString.notification
            : AppString.detailFund,
        backButton: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => controller.allEvents.isEmpty
                  ? Center(
                      child: AutoSizeText("Không có thông báo"),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) => ItemCard(
                        Icons.notifications,
                        controller.allEvents[index].name ?? "",
                        color: controller.allEvents[index].isNotified
                            ? Colors.white
                            : const Color.fromARGB(255, 241, 238, 238),
                        title:
                            "Diễn ra vào ${DateFormat('kk:mm dd-MM-yyyy').format(controller.allEvents[index].date ?? DateTime.now())}",
                      ),
                      itemCount: controller.allEvents.length,
                      shrinkWrap: true,
                      //physics: const NeverScrollableScrollPhysics(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
