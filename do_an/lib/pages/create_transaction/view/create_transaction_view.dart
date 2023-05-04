import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:do_an/base/dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/icons.dart';
import '../../../base/strings.dart';
import '../../../component/base_input_with_label.dart';
import '../../../component/input_text_form_field_model.dart';
import '../../../enum/input_formatter_enum.dart';
import '../controller/create_transaction_controller.dart';

class CreateTransactionPage extends GetView<CreateTransactionController> {
  const CreateTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: AutoSizeText(
            Get.arguments == null
                ? AppString.createTransaction
                : AppString.detailTransaction,
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
                Get.arguments == null ? AppString.save : AppString.edit,
                style: Get.textTheme.bodyLarge,
              ),
            )),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                InputTextWithLabel(
                  buildInputText: BuildInputText(
                    InputTextModel(
                      controller: controller.valueController,
                      //currentNode: controller.descriptionNode,
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
                  label: AppString.createNote,
                ),
                GestureDetector(
                  onTap: () => controller.chooseCategory(),
                  child: Card(
                    child: Obx(
                      () => ListTile(
                          leading: controller.transaction.value.categoryId! >= 0
                              ? Image.asset(
                                  "${ImageAsset.linkIconCategory}${controller.transaction.value.categoryId!}.png",
                                  width: 40,
                                  height: 40,
                                )
                              : null,
                          trailing: AutoSizeText(
                            AppString.selectCategory,
                            style: Get.textTheme.bodyMedium!
                                .copyWith(color: kPrimaryColor),
                          ),
                          title: AutoSizeText(
                              controller.transaction.value.categoryName)),
                    ),
                  ).paddingSymmetric(vertical: paddingSmall),
                ),
                // if (Get.arguments == true) ...[
                GestureDetector(
                  onTap: () => controller.selectDateRepeat(context),
                  child: Card(
                    child: ListTile(
                      trailing: AutoSizeText(
                        AppString.hintTime,
                        style: Get.textTheme.bodyMedium!
                            .copyWith(color: kPrimaryColor),
                      ),
                      title: Obx(() => AutoSizeText(
                            controller.transaction.value.isRepeat
                                ? "Lặp lại vào lúc ${DateFormat('kk:mm dd-MM-yyyy').format(controller.transaction.value.executionTime??DateTime.now())}"
                                : DateFormat('kk:mm dd-MM-yyyy').format(
                                    controller
                                        .transaction.value.executionTime??
                                        DateTime.now()),
                          )),
                    ),
                  ).paddingSymmetric(vertical: paddingSmall),
                ),
                // ] else ...[
                //   GestureDetector(
                //     onTap: () => controller.selectDate(context),
                //     child: Card(
                //       child: Obx(
                //         () => ListTile(
                //             leading: const Icon(Icons.date_range),
                //             trailing: AutoSizeText(
                //               AppString.hintTime,
                //               style: Get.textTheme.bodyMedium!
                //                   .copyWith(color: kPrimaryColor),
                //             ),
                //             title: AutoSizeText(
                //               DateFormat.yMMMd()
                //                   .format(controller.selectedDate.value),
                //               style: Get.textTheme.bodyMedium,
                //             )),
                //       ),
                //     ).paddingSymmetric(vertical: paddingSmall),
                //   ),
                // ],
                GestureDetector(
                  onTap: () => controller.chooseFund(),
                  child: Card(
                    child: Obx(
                      () => ListTile(
                        leading: controller.transaction.value.fundID! >= 0
                            ? Image.asset(
                                "${ImageAsset.linkIconFund}${controller.transaction.value.fundID!}.png",
                                width: 40,
                                height: 40,
                              )
                            : null,
                        trailing: AutoSizeText(
                          AppString.selectFund,
                          style: Get.textTheme.bodyMedium!
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
                          AppString.selectEvent,
                          style: Get.textTheme.bodyMedium!
                              .copyWith(color: kPrimaryColor),
                        ),
                        title: AutoSizeText(
                          controller.transaction.value.eventName,
                        ),
                      ),
                    ),
                  ).paddingSymmetric(vertical: paddingSmall),
                ),
                StatefulBuilder(
                  builder: (context, setState) =>
                      controller.transaction.value.imageLink.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () async {
                                      await controller.getImage();
                                      setState(() {});
                                    },
                                    child: const AutoSizeText(
                                      "Thêm hình ảnh",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  Container(
                                    height: 40.0,
                                  ),
                                ],
                              ),
                            )
                          : Image.memory(
                              controller.bytesImage(
                                  controller.transaction.value.imageLink),
                              fit: BoxFit.cover,
                            ).paddingSymmetric(vertical: paddingSmall),
                ),
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
