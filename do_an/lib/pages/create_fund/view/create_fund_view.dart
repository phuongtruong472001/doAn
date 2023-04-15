import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/base_input_with_label.dart';
import '../../../component/input_text_form_field_model.dart';
import '../controller/create_fund_controller.dart';

class CreateFundPage extends GetView<CreateFundController> {
  const CreateFundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: AutoSizeText(
          "Tạo mới ví",
          style: Get.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Center(
              child: InkWell(
            onTap: () => controller.createFund(),
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
                  controller: controller.fundNameController.value,
                  hintText: "Nhập tên ví",
                  iconNextTextInputAction: TextInputAction.done,
                  //inputFormatters: InputFormatterEnum.lengthLimitingText,
                  submitFunc: (v) => {},
                ),
              ),
              label: "Tên ví",
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
          ]).paddingSymmetric(
            horizontal: defaultPadding,
          ),
        ),
      ),
    );
  }
}
