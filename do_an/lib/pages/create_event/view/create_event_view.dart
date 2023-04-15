import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/colors.dart';
import '../../../base/dimen.dart';
import '../../../component/base_input_with_label.dart';
import '../../../component/input_text_form_field_model.dart';
import '../controller/create_event_controller.dart';

class CreateEventPage extends GetView<CreateEventController> {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: AutoSizeText(
          "Tạo mới sự kiện",
          style: Get.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Center(
              child: InkWell(
            onTap: () => controller.createEvent(),
            child: AutoSizeText(
              "LƯU",
              style: Get.textTheme.bodyLarge,
            ),
          )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            InputTextWithLabel(
              buildInputText: BuildInputText(
                InputTextModel(
                  controller: controller.nameController.value,
                  hintText: "Nhập tên sự kiện",
                  iconNextTextInputAction: TextInputAction.done,
                  //inputFormatters: InputFormatterEnum.lengthLimitingText,
                  submitFunc: (v) => {},
                ),
              ),
              label: "Tên sự kiện",
            ),
            InputTextWithLabel(
              buildInputText: BuildInputText(
                InputTextModel(
                  controller: controller.valueController.value,
                  hintText: "Nhập số tiền",
                  iconNextTextInputAction: TextInputAction.done,
                  //inputFormatters: InputFormatterEnum.lengthLimitingText,
                  submitFunc: (v) => {},
                ),
              ),
              label: "Số tiền",
            ),
            // GestureDetector(
            //    // onTap: () => controller.chooseFund(),
            //     child: Card(
            //       child: Obx(
            //         () => ListTile(
            //           leading: const Icon(Icons.book),
            //           trailing: AutoSizeText(
            //             "Chọn nguồn tiền",
            //             style: Get.textTheme.bodyText2!
            //                 .copyWith(color: kPrimaryColor),
            //           ),
            //           title: AutoSizeText(
            //             controller.event.value.,
            //           ),
            //         ),
            //       ),
            //     ).paddingSymmetric(vertical: paddingSmall),
            //   ),
            GestureDetector(
              onTap: () => controller.selectDate(context),
              child: Card(
                child: Obx(
                  () => ListTile(
                      leading: const Icon(Icons.date_range),
                      trailing: AutoSizeText(
                        "Chọn thời gian",
                        style: Get.textTheme.bodyMedium!
                            .copyWith(color: kPrimaryColor),
                      ),
                      title: AutoSizeText(
                        DateFormat.yMMMd()
                            .format(controller.selectedDate.value),
                        style: Get.textTheme.bodyMedium,
                      )),
                ),
              ).paddingSymmetric(vertical: paddingSmall),
            ),
          ]).paddingSymmetric(
            horizontal: defaultPadding,
          ),
        ),
      ),
    );
  }
}
