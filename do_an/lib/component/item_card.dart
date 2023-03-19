import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/colors.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.icon,
      required this.content,
      required this.title,
      required this.subTitle,
      this.color});
  final IconData icon;
  final String content;
  final String title;
  final String subTitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: AutoSizeText(
          content,
          style: Get.textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: AutoSizeText(
          title,
          style: Get.textTheme.bodyMedium!.copyWith(
            color: kSecondaryColor,
          ),
        ),
        trailing: AutoSizeText(
          subTitle,
          style: Get.textTheme.bodyMedium!.copyWith(
            color: color,
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}
