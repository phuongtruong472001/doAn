import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/database/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../enum/input_formatter_enum.dart';
import '../../../component/base_input_with_label.dart';
import '../../../component/input_text_form_field_model.dart';
import '../controller/create_transaction_controller.dart';

class CreateTransactionPage extends GetView<CreateTransactionController> {
  const CreateTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbHelper = DBHelper();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: AutoSizeText(
            Get.arguments == null ? "Tạo mới giao dịch" : "Chi tiết giao dịch",
            style: Get.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Center(
                child: InkWell(
              onTap: () => controller.createTransaction(),
              child: AutoSizeText(
                 Get.arguments == null ? "LƯU":"CẬP NHẬT",
                style: Get.textTheme.bodyText1,
              ),
            )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InputTextWithLabel(
                buildInputText: BuildInputText(
                  InputTextModel(
                    controller: controller.valueController,
                    //currentNode: controller.descriptionNode,
                    hintText: "Nhập số tiền",
                    iconNextTextInputAction: TextInputAction.done,
                    inputFormatters: InputFormatterEnum.digitsOnly,
                    submitFunc: (v) => {},
                  ),
                ),
                label: "Số tiền",
              ),
              InputTextWithLabel(
                buildInputText: BuildInputText(
                  InputTextModel(
                    controller: controller.descriptionController,
                    // currentNode: controller.descriptionNode,
                    hintText: "Nhập ghi chú",
                    iconNextTextInputAction: TextInputAction.done,
                    submitFunc: (v) => {},
                    iconLeading: Icons.notes_outlined,
                  ),
                ),
                label: "Ghi chú",
              ),
              GestureDetector(
                onTap: () => controller.chooseCategory(),
                child: Card(
                  child: Obx(
                    () => ListTile(
                        leading: const Icon(Icons.book),
                        trailing: AutoSizeText(
                          "Chọn danh mục",
                          style: Get.textTheme.bodyText2!
                              .copyWith(color: kPrimaryColor),
                        ),
                        title: AutoSizeText(
                            controller.transaction.value.categoryName)),
                  ),
                ).paddingSymmetric(vertical: paddingSmall),
              ),
              GestureDetector(
                onTap: () => controller.selectDate(context),
                child: Card(
                  child: Obx(
                    () => ListTile(
                        leading: const Icon(Icons.date_range),
                        trailing: AutoSizeText(
                          "Chọn thời gian",
                          style: Get.textTheme.bodyText2!
                              .copyWith(color: kPrimaryColor),
                        ),
                        title: AutoSizeText(
                          DateFormat.yMMMd()
                              .format(controller.selectedDate.value),
                          style: Get.textTheme.bodyText2,
                        )),
                  ),
                ).paddingSymmetric(vertical: paddingSmall),
              ),
              GestureDetector(
                onTap: () => controller.chooseFund(),
                child: Card(
                  child: Obx(
                    () => ListTile(
                      leading: const Icon(Icons.book),
                      trailing: AutoSizeText(
                        "Chọn nguồn tiền",
                        style: Get.textTheme.bodyText2!
                            .copyWith(color: kPrimaryColor),
                      ),
                      title: AutoSizeText(
                        controller.transaction.value.fundName,
                      ),
                    ),
                  ),
                ).paddingSymmetric(vertical: paddingSmall),
              ),
              GestureDetector(
                onTap: () => controller.chooseEvent(),
                child: Card(
                  child: Obx(
                    () => ListTile(
                      leading: const Icon(Icons.event),
                      trailing: AutoSizeText(
                        "Chọn sự kiện",
                        style: Get.textTheme.bodyText2!
                            .copyWith(color: kPrimaryColor),
                      ),
                      title: AutoSizeText(
                        controller.transaction.value.eventName,
                      ),
                    ),
                  ),
                ).paddingSymmetric(vertical: paddingSmall),
              ),
            ],
          ).paddingSymmetric(
            horizontal: defaultPadding,
          ),
        ),
      ),
    );
  }
}
