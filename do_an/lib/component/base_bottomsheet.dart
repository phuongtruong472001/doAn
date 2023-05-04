import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/database/database.dart';
import 'package:do_an/model/repeat_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BottomSheetSelectTime extends GetView<BaseBottomSheetController> {
  BottomSheetSelectTime({Key? key}) : super(key: key);
  @override
  BaseBottomSheetController controller = Get.put(BaseBottomSheetController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            color: Colors.transparent,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const AutoSizeText("Lặp lại"),
                    Obx(
                      () => Switch(
                        // thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                        //   (Set<MaterialState> states) {
                        //     // Thumb icon when the switch is selected.
                        //     if (states.contains(MaterialState.selected)) {
                        //       return const Icon(Icons.check);
                        //     }
                        //     return const Icon(Icons.close);
                        //   },
                        // ),
                        value: controller.isRepeat.value,
                        onChanged: (bool value) {
                          controller.isRepeat.value = value;
                        },
                      ),
                    )
                  ],
                ),
                Obx(
                  () => (!controller.isRepeat.value)
                      ? Column(
                          children: [
                            Row(
                              children: [
                                const AutoSizeText("Vui lòng chọn ngày"),
                                TextButton(
                                  onPressed: () =>
                                      controller.selectDate(context),
                                  child: Obx(
                                    () => AutoSizeText(
                                      DateFormat('dd/MM/yyyy').format(
                                          controller.selectedDate.value),
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const AutoSizeText("Vào lúc "),
                                TextButton(
                                  onPressed: () =>
                                      controller.selectTime(context),
                                  child: Obx(
                                    () => AutoSizeText(
                                      controller.time.value.format(context),
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButton<String>(
                              value: controller.listTypeTimeRepeat[
                                  controller.typeTime.value],
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                controller.typeTime.value = controller
                                    .listTypeTimeRepeat
                                    .indexOf(value ?? '');
                                switch (controller.typeTime.value) {
                                  case 0:
                                    controller.amountName.value = "ngày";
                                    break;
                                  case 1:
                                    controller.amountName.value = "tuần";
                                    break;
                                  case 2:
                                    controller.amountName.value = "tháng";
                                    break;
                                }
                              },
                              items: controller.listTypeTimeRepeat
                                  .map<DropdownMenuItem<String>>((element) {
                                return DropdownMenuItem<String>(
                                  value: element,
                                  child: AutoSizeText(element),
                                );
                              }).toList(),
                            ),
                            Row(
                              children: [
                                const AutoSizeText("Từ ngày "),
                                TextButton(
                                  onPressed: () =>
                                      controller.selectDate(context),
                                  child: Obx(
                                    () => AutoSizeText(
                                      DateFormat('dd/MM/yyyy').format(
                                          controller.selectedDate.value),
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                                const AutoSizeText("Vào lúc "),
                                TextButton(
                                  onPressed: () =>
                                      controller.selectTime(context),
                                  child: Obx(
                                    () => AutoSizeText(
                                      controller.time.value.format(context),
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const AutoSizeText("Mỗi "),
                                SizedBox(
                                  width: 80,
                                  height: 30,
                                  child: TextField(
                                    controller: controller.quantityController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]'),
                                      ),
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                AutoSizeText(controller.amountName.value),
                              ],
                            ),
                            AutoSizeText(
                                "vào cùng 1 ngày hàng ${controller.amountName.value}"),
                            DropdownButton<String>(
                              value: controller
                                  .listTypeRepeat[controller.typeRepeat.value],
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                controller.typeRepeat.value = controller
                                    .listTypeRepeat
                                    .indexOf(value ?? '');
                                switch (controller.typeRepeat.value) {
                                  case 0:
                                    controller.amountName.value = "ngày";
                                    break;
                                  case 1:
                                    controller.amountName.value = "tuần";
                                    break;
                                  case 2:
                                    controller.amountName.value = "tháng";
                                    break;
                                }
                              },
                              items: controller.listTypeRepeat
                                  .map<DropdownMenuItem<String>>((element) {
                                return DropdownMenuItem<String>(
                                  value: element,
                                  child: AutoSizeText(element),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const AutoSizeText(
                        AppString.cancel,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.doneRepeatTime();
                        Get.back(result: controller.repeatTime.value);
                      },
                      child: const AutoSizeText(
                        AppString.accept,
                      ),
                    ),
                  ],
                ),
              ],
            )).paddingAll(
              defaultPadding,
            ),
          ),
        ).paddingSymmetric(horizontal: defaultPadding),
      ],
    );
  }
}

class BaseBottomSheetController extends GetxController {
  List<String> listTypeTimeRepeat = [
    "Hàng ngày",
    "Hàng tuần",
    "Hàng tháng",
  ];
  List<String> listTypeRepeat = [
    "Mãi mãi",
    "1 lần",
  ];
  final quantityController = TextEditingController(text: "1");
  Rx<RepeatTime> repeatTime = RepeatTime().obs;

  RxBool choosedDate = false.obs;
  var selectedDate = DateTime.now().obs;
  DBHelper dbHelper = DBHelper();
  Rx<TimeOfDay> time = const TimeOfDay(hour: 7, minute: 15).obs;
  RxInt typeTime = 0.obs;
  RxInt typeRepeat = 0.obs;
  RxBool isRepeat = false.obs;
  RxString amountName = "ngày".obs;

  void selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    choosedDate.value = true;
    if (picked != null && picked != DateTime.now()) {
      selectedDate.value = picked;
    }
  }

  @override
  void onReady() {}

  void doneRepeatTime() {
    repeatTime.value.timeOfDay = time.value;
    repeatTime.value.dateTime = selectedDate.value;
    repeatTime.value.nameRepeat = listTypeTimeRepeat[typeTime.value];
    repeatTime.value.typeTime = typeTime.value;
    repeatTime.value.quantityTime = int.parse(quantityController.text);
    repeatTime.value.typeRepeat = typeRepeat.value;
    repeatTime.value.isRepeat = isRepeat.value;
    repeatTime.value.amount = int.parse(quantityController.text);
  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time.value,
    );
    if (newTime != null) {
      time.value = newTime;
    }
  }
}
