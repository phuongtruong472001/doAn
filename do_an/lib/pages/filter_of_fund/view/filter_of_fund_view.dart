import 'package:do_an/pages/filter_of_fund/controller/filter_of_fund_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/dimen.dart';
import '../../../component/util_widget.dart';
import '../../../model/filter.dart';

class FilterOfFundPage extends GetView<FilterOfFundController> {
  const FilterOfFundPage({Key? key}) : super(key: key);

  @override
  FilterOfFundController get controller => Get.put(FilterOfFundController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildItemTimeSelect(context),
                ],
              ),
            ),
          ),
          _buildBottomAction(),
        ],
      ).paddingAll(defaultPadding),
    );
  }

  Widget _buildItemTimeSelect(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Thời gian",
              style: Get.textTheme.bodyLarge,
            ),
            const Spacer(),
            Obx(
              () => Visibility(
                visible: controller.fromDateStr.value.isNotEmpty ||
                    controller.toDateStr.value.isNotEmpty,
                child: GestureDetector(
                  onTap: () {
                    controller.fromDateStr.value =
                        controller.toDateStr.value = '';
                  },
                  child: Text(
                    "Xóa",
                    style:
                        Get.textTheme.bodyLarge!.copyWith(color: Colors.blue),
                  ).paddingOnly(left: paddingSmall),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: paddingSmall,
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.black, style: BorderStyle.solid),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: buildButtonDateOption("Từ ngày", controller.fromDateStr,
                    onClick: () async {
                  final DateTime? picked = await showDatePicker(
                    initialDate: controller.fromDateStr.value.isNotEmpty
                        ? convertStringToDate(controller.fromDateStr.value)
                        : DateTime.now(),
                    context: context,
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null) {
                    controller.fromDateStr.value =
                        formatDateTimeToString(picked);
                  }
                }),
              ),
              const VerticalDivider(width: 1)
                  .paddingSymmetric(vertical: defaultPadding),
              Expanded(
                child: buildButtonDateOption("Đến ngày", controller.toDateStr,
                    onClick: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: controller.toDateStr.value.isEmpty
                        ? DateTime.now()
                        : convertStringToDate(controller.toDateStr.value),
                    firstDate: controller.fromDateStr.value.isNotEmpty
                        ? convertStringToDate(controller.fromDateStr.value)
                        : DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null) {
                    controller.toDateStr.value = formatDateTimeToString(picked);
                  }
                }),
              ),
              const VerticalDivider(width: 1)
                  .paddingSymmetric(vertical: defaultPadding),
            ],
          ),
        ),
      ],
    );
  }

  DateTime convertStringToDate(String dateTime) {
    return DateTime.parse(dateTime);
  }

  String formatDateTimeToString(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  Widget buildButtonDateOption(String title, RxString dateStr,
      {Function()? onClick}) {
    return TextButton(
      onPressed: onClick,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: Get.textTheme.titleMedium!.copyWith(color: Colors.grey),
          ).paddingOnly(bottom: paddingSmall),
          Obx(
            () => Text(
              initDateTime(dateStr.value),
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: Get.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  String initDateTime(String dateTime) =>
      dateTime.isEmpty || dateTime == "null" ? "--/--/----" : dateTime;

  Widget _buildBottomAction() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: UtilWidget.buildButton(
            "Bỏ lọc",
            () async {
              Get.back(result: "Cancel");
            },
          ),
        ),
        const SizedBox(width: paddingSmall),
        Expanded(
          flex: 1,
          child: Obx(
            () => UtilWidget.buildButton(
              "Áp dụng",
              () {
                if (controller.fromDateStr.value.isEmpty ||
                    controller.toDateStr.value.isEmpty) {
                  return;
                }
                Get.back(
                  result: FilterItem(
                      fromDate: controller.fromDateStr.value,
                      toDate: controller.toDateStr.value),
                );
              },
              color: (controller.fromDateStr.value.isEmpty ||
                      controller.toDateStr.value.isEmpty)
                  ? Colors.grey
                  : Colors.blue,
            ),
          ),
        ),
      ],
    ).paddingSymmetric(vertical: paddingSmall);
  }
}
