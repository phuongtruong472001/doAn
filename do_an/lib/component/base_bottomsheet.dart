import 'package:do_an/base/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetSelectTime extends StatelessWidget {
  const BottomSheetSelectTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 2 / 3,
      height: Get.height / 2,
      child: Column(
        children: [
          Row(
            children: const [Text("Lặp hàng tháng")],
          ),
          Row(
            children: const [
              Text("Từ ngày"),
              Text("Lúc 9:00"),
            ],
          ),
          const Text("Mỗi 1 tháng"),
          const Text("vào cùng 1 ngày hàng tháng"),
          const Text("mãi mãi"),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  AppString.cancel,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  AppString.accept,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
