import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseHeaderNoBackButton extends StatelessWidget {
  const BaseHeaderNoBackButton({
    super.key,
    required this.content,
    this.icon,
    this.title,
    this.function,
  });
  final String content;
  final IconData? icon;
  final String? title;
  final Function? function;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AutoSizeText(
              content,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (icon != null) ...[
              IconButton(
                icon: Icon(icon ?? Icons.history_sharp),
                onPressed: () => function,
              )
            ]
          ],
        ),
        AutoSizeText(
          title!,
          style: Get.textTheme.bodyMedium!.copyWith(
            color: kSecondaryColor,
          ),
        ),
      ],
    );
  }
}
