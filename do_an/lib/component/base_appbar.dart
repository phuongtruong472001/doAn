import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? textIconColor;
  final bool backButton;
  final String? title;
  final double? height;
  final List<Widget>? menuItem;
  final bool hideBack;
  final bool isCenterTitle;

  WidgetAppBar({
    this.backgroundColor ,
    this.textIconColor = Colors.white,
    this.backButton = false,
    this.title = '',
    this.menuItem,
    this.height: kToolbarHeight,
    this.hideBack = false,
    this.isCenterTitle = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: menuItem,
      toolbarHeight: preferredSize.height,
      iconTheme: IconThemeData(
        color: textIconColor,
      ),
      leading: backButton
          ? BackButton(
              color: Colors.white,
            )
          : null,
      title: Text(
        title!,
        style: Get.textTheme.bodyText1!.copyWith(
          fontSize: 16,
          color: textIconColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue[400],
      centerTitle: isCenterTitle,
    );
  }
}
