import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetSelectTime extends StatelessWidget {
  BottomSheetSelectTime({Key? key}) : super(key: key);
  List<String> list = <String>[
    "Lặp hàng ngày",
    "Lặp hàng tuần",
    "Lặp hàng tháng",
  ];
  List<String> listRepeatTime = <String>[
    "Mãi mãi",
    "1 lần",
  ];

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;
    String dropdownValueTypeRepeat = listRepeatTime.first;
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
                  DropdownButton<String>(
                    value: dropdownValue,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: AutoSizeText(value),
                      );
                    }).toList(),
                  ),
                  Row(
                    children: [
                      const AutoSizeText("Từ ngày "),
                      TextButton(
                        onPressed: () {},
                        child: const AutoSizeText(
                          "Hôm nay ",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      AutoSizeText("Mỗi 1 tháng"),
                      SizedBox(
                        width: 50,
                        //height: 20,
                        child: TextField(),
                      ),
                    ],
                  ),
                  const AutoSizeText("vào cùng 1 ngày hàng tháng"),
                  DropdownButton<String>(
                    value: dropdownValueTypeRepeat,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                    },
                    items: listRepeatTime
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: AutoSizeText(value),
                      );
                    }).toList(),
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
                        onPressed: () {},
                        child: const AutoSizeText(
                          AppString.accept,
                        ),
                      ),
                    ],
                  )
                ],
              ).paddingAll(
                defaultPadding,
              ),
            ),
          ).paddingSymmetric(horizontal: defaultPadding),
        ),
      ],
    );
  }
}
