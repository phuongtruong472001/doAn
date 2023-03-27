import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/base_input_with_label.dart';
import '../../../component/input_text_form_field_model.dart';
import '../controller/create_transaction_controller.dart';

class CreateTransactionPage extends GetView<CreateTransactionController> {
  const CreateTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const AutoSizeText("Tạo mới giao dịch"),
        centerTitle: true,
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
                  hintText: "Chọn Nhóm",
                  iconNextTextInputAction: TextInputAction.done,
                  submitFunc: (v) => {},
                ),
              ),
              label: "",
            ),
            InputTextWithLabel(
              buildInputText: BuildInputText(
                InputTextModel(
                  controller: controller.noteController.value,
                  //currentNode: controller.descriptionNode,
                  hintText: "",
                  iconNextTextInputAction: TextInputAction.done,
                  submitFunc: (v) => {},
                ),
              ),
              label: "",
            )
          ],
        ).paddingSymmetric(
          horizontal: defaultPadding,
        ),
      ),
    );
  }
}
