import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Enum/input_formatter_enum.dart';
import '../../../base/strings.dart';
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
          Get.arguments == null ? AppString.createFund : AppString.detailFund,
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
              Get.arguments == null ? AppString.save : AppString.edit,
              style: Get.textTheme.bodyLarge,
            ),
          )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formData,
            child: Column(
              children: [
                InputTextWithLabel(
                  buildInputText: BuildInputText(
                    InputTextModel(
                      controller: controller.fundNameController,
                      hintText: AppString.hintNameFund,
                      iconNextTextInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == "0") {
                          return "Không được để trống";
                        }
                        return "";
                      },
                      //inputFormatters: InputFormatterEnum.lengthLimitingText,
                      submitFunc: (v) => {},
                    ),
                  ),
                  label: AppString.nameFund,
                ),
                InputTextWithLabel(
                  buildInputText: BuildInputText(
                    InputTextModel(
                      controller: controller.valueController,
                      hintText: AppString.hintValue,
                      iconNextTextInputAction: TextInputAction.done,
                      inputFormatters: InputFormatterEnum.currency,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Không được để trống";
                        }
                        return "";
                      },
                      submitFunc: (v) => {},
                    ),
                  ),
                  label: AppString.value,
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
