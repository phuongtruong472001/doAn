import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../controller/event_controller.dart';

class EventPage extends GetView<EventController> {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(Get.arguments == null ?  AppString.allEvent: AppString.chooseEvent),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            AppRoutes.createEvent,
            arguments: true,
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () =>
                      controller.onTapItem(controller.listEvents[index]),
                  child: ListTile(
                    leading: const Icon(Icons.sports_basketball_rounded),
                    title: AutoSizeText(
                      controller.listEvents[index].name ?? "",
                    ),
                    subtitle: AutoSizeText(
                      controller.listEvents[index].estimateValue.toString(),
                    ),
                  ).paddingAll(paddingSmall),
                ),
                itemCount: controller.listEvents.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
