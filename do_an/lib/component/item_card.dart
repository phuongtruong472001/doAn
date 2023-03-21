import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/colors.dart';

class ItemCard extends StatelessWidget {
  ItemCard(
    this.icon,
    this.content, {Key? key, 
    
    this.title,
    this.subTitle,
    this.color,
    this.isTreeLine = false,
  }) : super(key: key);
  late IconData icon;
  late String content;
  late String? title;
  late String? subTitle;
  late Color? color;
  late bool? isTreeLine;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: AutoSizeText(
        content,
        style: Get.textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: title != null
          ? AutoSizeText(
              title ?? "",
              style: Get.textTheme.bodyMedium!.copyWith(
                color: kSecondaryColor,
              ),
            )
          : null,
      trailing: subTitle != null
          ? AutoSizeText(
              subTitle ?? "",
              style: Get.textTheme.bodyMedium!.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      isThreeLine: isTreeLine ?? false,
    );
  }
}
