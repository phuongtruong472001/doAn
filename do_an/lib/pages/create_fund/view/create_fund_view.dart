import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/component/base_appbar.dart';
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
      appBar: WidgetAppBar(
        title:
            Get.arguments == null ? AppString.createFund : AppString.detailFund,
        menuItem: [
          Center(
              child: InkWell(
            onTap: () => controller.createFund(),
            child: AutoSizeText(
              Get.arguments == null ? AppString.save : AppString.edit,
              style: Get.textTheme.bodyLarge,
            ),
          )).marginOnly(left: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formData,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: BuildInputText(
                  InputTextModel(
                    controller: controller.fundNameController,
                    hintText: AppString.hintNameFund,
                    fillColor: Colors.white,
                    iconNextTextInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Không được để trống";
                      }
                      return null;
                    },
                    submitFunc: (v) => {},
                  ),
                ),
              ).paddingSymmetric(vertical: paddingSmall),
              Card(
                child: BuildInputText(
                  InputTextModel(
                    controller: controller.valueController,
                    hintText: AppString.hintValue,
                    iconNextTextInputAction: TextInputAction.done,
                    textInputType: TextInputType.number,
                    inputFormatters: InputFormatterEnum.currency,
                    submitFunc: (v) => {},
                  ),
                ),
              ).paddingSymmetric(vertical: paddingSmall),
              // const AutoSizeText("Chọn loại ví"),
              Card(
                child: Obx(
                  () => DropdownButton(
                    isExpanded: true,
                    value: controller.listWallet[controller.typeWallet.value],
                    elevation: 16,
                    style:
                        Get.textTheme.bodyText1!.copyWith(color: Colors.black),
                    underline: Container(),
                    onChanged: (String? value) {
                      controller.typeWallet.value =
                          controller.listWallet.indexOf(value ?? '');
                    },
                    items: controller.listWallet
                        .map<DropdownMenuItem<String>>((element) {
                      return DropdownMenuItem<String>(
                        value: element,
                        child: AutoSizeText(element),
                      );
                    }).toList(),
                  ),
                ).marginSymmetric(horizontal: paddingSmall),
              ).paddingSymmetric(vertical: paddingSmall),
            ],
          ).paddingSymmetric(
            horizontal: defaultPadding,
          ),
        ),
      ),
    );
  }
}
