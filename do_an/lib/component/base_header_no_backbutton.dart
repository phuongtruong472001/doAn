import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseHeaderNoBackButton extends StatelessWidget {
  const BaseHeaderNoBackButton({Key? key, 
    
    required this.content,
    this.icon,
    this.title,
    this.function,
  }) : super(key: key);
  final String content;
  final IconData? icon;
  final String? title;
  final Function? function;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                onPressed: () => function!.call(),
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
