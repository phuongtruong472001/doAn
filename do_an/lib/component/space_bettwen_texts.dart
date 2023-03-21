import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/colors.dart';

class SpaceBetweenLetter extends StatelessWidget {
  final String title;
  final String subTitle;

  const SpaceBetweenLetter({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(title),
        AutoSizeText(
          subTitle,
          style: Get.textTheme.bodyText1!.copyWith(color: kCorrectColor),
        ),
      ],
    );
  }
}
