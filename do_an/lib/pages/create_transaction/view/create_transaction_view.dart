import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/component/base_appbar.dart';
import 'package:do_an/component/base_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/strings.dart';
import '../../../component/base_input_with_label.dart';
import '../../../component/input_text_form_field_model.dart';
import '../../../enum/input_formatter_enum.dart';
import '../controller/create_transaction_controller.dart';

class CreateTransactionPage extends GetView<CreateTransactionController> {
  const CreateTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: Get.arguments == null
            ? AppString.createTransaction
            : AppString.detailTransaction,
        // menuItem: [
        //   TextButton(
        //     onPressed: () async => await controller.createTransaction(),
        //     child: Icon(
        //       Icons.check,
        //       color: Colors.white,
        //     ),
        //   ).marginOnly(left: 10),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Card(
                      child: BuildInputText(
                        InputTextModel(
                          controller: controller.valueController,
                          //currentNode: controller.descriptionNode,
                          hintText: AppString.hintValue,
                          iconNextTextInputAction: TextInputAction.done,
                          inputFormatters: InputFormatterEnum.currency,
                          textInputType: TextInputType.number,
                          textSize: 25,
                          iconLeading: Icons.attach_money_outlined,
                          submitFunc: (v) => {},
                          validator: (value) {
                            if (value == "0") {
                              return "Không được để trống";
                            }
                            return null;
                          },
                        ),
                      ),
                    ).paddingOnly(top: paddingSmall),
                    Card(
                      child: BuildInputText(
                        InputTextModel(
                          controller: controller.descriptionController,
                          // currentNode: controller.descriptionNode,
                          hintText: AppString.editNote,
                          iconNextTextInputAction: TextInputAction.done,
                          submitFunc: (v) => {},
                          iconLeading: Icons.notes_outlined,
                        ),
                      ),
                    ).paddingOnly(top: paddingSmall),
                    GestureDetector(
                      onTap: () => controller.chooseCategory(),
                      child: Card(
                        child: Obx(
                          () => ListTile(
                              leading: const Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                              trailing: Icon(Icons.keyboard_arrow_down_outlined),
                              title: AutoSizeText(
                                controller.transaction.value.categoryId! >= 0
                                    ? controller.transaction.value.categoryName
                                    : AppString.selectCategory,
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  color: controller.transaction.value.categoryId! >= 0
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              )),
                        ),
                      ),
                    ).paddingOnly(top: paddingSmall),
                    // if (Get.arguments == true) ...[
                    GestureDetector(
                      onTap: () => controller.selectDateRepeat(context),
                      child: Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.timer,
                            color: Colors.black,
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_down_outlined,
                          ),
                          title: Obx(
                            () => AutoSizeText(
                                controller.transaction.value.isRepeat
                                    ? "Lặp lại vào lúc ${DateFormat('kk:mm dd-MM-yyyy').format(controller.transaction.value.executionTime ?? DateTime.now())}"
                                    : DateFormat('kk:mm dd-MM-yyyy').format(
                                        controller.transaction.value.executionTime ??
                                            DateTime.now(),
                                      ),
                                style: Get.textTheme.bodyMedium),
                          ),
                        ),
                      ),
                    ).paddingOnly(top: paddingSmall),
                    GestureDetector(
                      onTap: () => controller.chooseFund(),
                      child: Card(
                        child: Obx(
                          () => ListTile(
                            leading: const Icon(
                              Icons.wallet,
                              color: Colors.black,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_down_outlined),
                            title: AutoSizeText(
                              controller.transaction.value.fundID! >= 0
                                  ? controller.transaction.value.fundName
                                  : AppString.selectFund,
                              style: Get.textTheme.bodyMedium!.copyWith(
                                color: controller.transaction.value.fundID! >= 0
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).paddingOnly(top: paddingSmall),
                    GestureDetector(
                      onTap: () => controller.chooseEvent(),
                      child: Card(
                        child: Obx(
                          () => ListTile(
                            leading: const Icon(
                              Icons.event,
                              color: Colors.black,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_down_outlined),
                            title: AutoSizeText(
                              controller.transaction.value.eventId! >= 0
                                  ? controller.transaction.value.eventName
                                  : AppString.selectEvent,
                              style: Get.textTheme.bodyMedium!.copyWith(
                                color: controller.transaction.value.eventId! >= 0
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).paddingOnly(top: paddingSmall),
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
                                ),
                    ).paddingSymmetric(vertical: paddingSmall),
                  ],
                ).paddingSymmetric(
                  horizontal: defaultPadding,
                ),
              ),
            ),
          ),
          BaseButton(
            Get.arguments == null ? AppString.save : AppString.edit,
            controller.manageTransaction,
          ),
        ],
      ),
    );
  }
}
