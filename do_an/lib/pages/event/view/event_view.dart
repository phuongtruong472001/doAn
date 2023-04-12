import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/event_controller.dart';

class EventPage extends GetView<EventController> {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Chọn sự kiện"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => controller.onTapItem(controller.listEvents[index]),
                child: const ListTile(
                  leading: Icon(Icons.sports_basketball_rounded),
                  title: AutoSizeText("Tiền mặt"),
                  subtitle: AutoSizeText("2000000 đ"),
                ).paddingAll(paddingSmall),
              ),
              itemCount: controller.listEvents.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            )
          ],
        ),
      ),
    );
  }
}
