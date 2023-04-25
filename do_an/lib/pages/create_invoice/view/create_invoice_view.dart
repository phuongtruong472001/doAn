import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:do_an/base/dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/strings.dart';
import '../../../component/base_input_with_label.dart';
import '../../../component/input_text_form_field_model.dart';
import '../../../enum/input_formatter_enum.dart';
import '../controller/create_invoice_controller.dart';

class CreateInvoicePage extends GetView<CreateInvoiceController> {
  const CreateInvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: AutoSizeText(
            Get.arguments == null
                ? AppString.createInvoice
                : AppString.detailInvoice,
            style: Get.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Center(
                child: InkWell(
              onTap: () => controller.createInvoice(),
              child: AutoSizeText(
                Get.arguments == null ? AppString.save : AppString.edit,
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
                    hintText: AppString.hintValue,
                    iconNextTextInputAction: TextInputAction.done,
                    inputFormatters: InputFormatterEnum.digitsOnly,
                    submitFunc: (v) => {},
                  ),
                ),
                label: AppString.value,
              ),
              GestureDetector(
                onTap: () => controller.chooseCategory(),
                child: Card(
                  child: Obx(
                    () => ListTile(
                        leading: const Icon(Icons.book),
                        trailing: AutoSizeText(
                          AppString.selectCategory,
                          style: Get.textTheme.bodyText2!
                              .copyWith(color: kPrimaryColor),
                        ),
                        title: AutoSizeText(
                            controller.invoice.value.categoryName ?? "")),
                  ),
                ).paddingSymmetric(vertical: paddingSmall),
              ),
              InputTextWithLabel(
                buildInputText: BuildInputText(
                  InputTextModel(
                    controller: controller.descriptionController,
                    // currentNode: controller.descriptionNode,
                    hintText: AppString.editNote,
                    iconNextTextInputAction: TextInputAction.done,
                    submitFunc: (v) => {},
                    iconLeading: Icons.notes_outlined,
                  ),
                ),
                label: AppString.editNote,
              ),
              GestureDetector(
                onTap: () => controller.selectDate(context),
                child: Card(
                  child: Obx(
                    () => ListTile(
                        leading: const Icon(Icons.date_range),
                        trailing: AutoSizeText(
                          AppString.hintTime,
                          style: Get.textTheme.bodyText2!
                              .copyWith(color: kPrimaryColor),
                        ),
                        title: AutoSizeText(
                          "${controller.invoice.value.timeOfDay!.format(context)} ${DateFormat('dd-MM-yyy').format(controller.invoice.value.executionTime ?? DateTime.now())}",
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
                        AppString.selectFund,
                        style: Get.textTheme.bodyText2!
                            .copyWith(color: kPrimaryColor),
                      ),
                      title: AutoSizeText(
                        controller.invoice.value.fundName ?? "",
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
