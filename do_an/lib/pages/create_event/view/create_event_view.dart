import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Enum/input_formatter_enum.dart';
import '../../../base/colors.dart';
import '../../../base/dimen.dart';
import '../../../base/strings.dart';
import '../../../component/base_input_with_label.dart';
import '../../../component/input_text_form_field_model.dart';
import '../../../component/item_card.dart';
import '../controller/create_event_controller.dart';

class CreateEventPage extends GetView<CreateEventController> {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: AutoSizeText(
          Get.arguments == null ? AppString.createEvent : AppString.detailEvent,
          style: Get.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          if (Get.arguments != null)
            TextButton(
              onPressed: () => controller.completeEvent(),
              child: Obx(() => AutoSizeText(
                    controller.event.value.allowNegative == 1
                        ? AppString.complete
                        : AppString.notComplete,
                    style: Get.textTheme.bodyLarge!.copyWith(
                      color: controller.event.value.allowNegative != 1
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          TextButton(
            onPressed: () => controller.createEvent(),
            child: AutoSizeText(
              Get.arguments == null ? AppString.save : AppString.edit,
              style: Get.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formData,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputTextWithLabel(
                  buildInputText: BuildInputText(
                    InputTextModel(
                      controller: controller.nameController.value,
                      hintText: AppString.hintNameEvent,
                      iconNextTextInputAction: TextInputAction.done,
                      //inputFormatters: InputFormatterEnum.lengthLimitingText,
                      submitFunc: (v) => {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Không được để trống";
                        }
                        return null;
                      },
                    ),
                  ),
                  label: AppString.nameEvent,
                ),
                InputTextWithLabel(
                  buildInputText: BuildInputText(
                    InputTextModel(
                      controller: controller.valueController,
                      hintText: AppString.hintValue,
                      iconNextTextInputAction: TextInputAction.done,
                      inputFormatters: InputFormatterEnum.currency,
                      submitFunc: (v) => {},
                      validator: (value) {
                        if (value == "0") {
                          return "Không được để trống";
                        }
                        return null;
                      },
                    ),
                  ),
                  label: AppString.value,
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
                            AppString.hintDay,
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
                GestureDetector(
                  onTap: () => controller.selectTime(context),
                  child: Card(
                    child: Obx(
                      () => ListTile(
                          leading: const Icon(Icons.date_range),
                          trailing: AutoSizeText(
                            AppString.hintHour,
                            style: Get.textTheme.bodyMedium!
                                .copyWith(color: kPrimaryColor),
                          ),
                          title: AutoSizeText(
                            controller.time.value.format(context),
                            style: Get.textTheme.bodyMedium,
                          )),
                    ),
                  ).paddingSymmetric(vertical: paddingSmall),
                ),
                if (Get.arguments != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AutoSizeText(
                            "Đã chi tiêu ${(controller.event.value.value.toString().toVND())}",
                          ),
                          Visibility(
                            visible: controller.event.value.value >
                                    controller.event.value.estimateValue &&
                                Get.arguments != null,
                            child: AutoSizeText(
                              " vượt mức ${(controller.event.value.value - controller.event.value.estimateValue).toString().toVND()}",
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AutoSizeText(
                        "Danh sách các giao dịch của sự kiện '${controller.event.value.name}'",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.listTransaction.isNotEmpty,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TransactionWidget(
                                controller.listTransaction[index],
                              );
                            },
                            itemCount: controller.listTransaction.length,
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ).paddingSymmetric(
              horizontal: defaultPadding,
            ),
          ),
        ),
      ),
    );
  }
}
