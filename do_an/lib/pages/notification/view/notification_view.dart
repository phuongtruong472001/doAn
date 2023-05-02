import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/component/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/notification_controller.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: AutoSizeText(
                "Thông báo",
                style: Get.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).paddingAll(defaultPadding),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Card(
                  child: ItemCard(
                    Icons.notifications,
                    controller.allEvents[index].name ?? "",
                    title:
                        "Diễn ra vào ${DateFormat('kk:mm dd-MM-yyyy').format(controller.allEvents[index].date ?? DateTime.now())}",
                  ),
                ),
                itemCount: controller.allEvents.length,
                shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
