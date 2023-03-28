import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:do_an/base/dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Enum/input_formatter_enum.dart';
import '../../../component/base_input_with_label.dart';
import '../../../component/input_text_form_field_model.dart';
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
            "Tạo mới giao dịch",
            style: Get.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Center(
                child: AutoSizeText(
              "LƯU",
              style: Get.textTheme.bodyText1,
            )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InputTextWithLabel(
                buildInputText: BuildInputText(
                  InputTextModel(
                    controller: controller.valueController.value,
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
                      controller: controller.categoryController.value,
                      // currentNode: controller.descriptionNode,
                      hintText: "Nhập ghi chú",
                      iconNextTextInputAction: TextInputAction.done,
                      submitFunc: (v) => {},
                      iconLeading: Icons.notes_outlined),
                ),
                label: "Ghi chú",
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.book),
                  trailing: AutoSizeText(
                    "Chọn danh mục",
                    style:
                        Get.textTheme.bodyText2!.copyWith(color: kPrimaryColor),
                  ),
                ),
              ).paddingSymmetric(vertical: paddingSmall),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.date_range),
                  trailing: AutoSizeText(
                    "Chọn thời gian",
                    style:
                        Get.textTheme.bodyText2!.copyWith(color: kPrimaryColor),
                  ),
                ),
              ).paddingSymmetric(vertical: paddingSmall),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.book),
                  trailing: AutoSizeText(
                    "Chọn nguồn tiền",
                    style:
                        Get.textTheme.bodyText2!.copyWith(color: kPrimaryColor),
                  ),
                ),
              ).paddingSymmetric(vertical: paddingSmall),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.event),
                  trailing: AutoSizeText(
                    "Chọn sự kiện",
                    style:
                        Get.textTheme.bodyText2!.copyWith(color: kPrimaryColor),
                  ),
                ),
              ).paddingSymmetric(vertical: paddingSmall),
            ],
          ).paddingSymmetric(
            horizontal: defaultPadding,
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: TextButton(
        //   style: ButtonStyle(
        //     backgroundColor:
        //         const MaterialStatePropertyAll<Color>(kPrimaryColor),
        //     minimumSize:
        //         MaterialStatePropertyAll<Size>(Size(Get.width / 2, 50)),
        //   ),
        //   onPressed: () {},
        //   child: AutoSizeText(
        //     "Thêm mới",
        //     style: Get.textTheme.bodyLarge!.copyWith(
        //       color: Colors.white,
        //       fontSize: sizeTextSmall,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
