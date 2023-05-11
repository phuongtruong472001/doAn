import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class BaseHeader extends AppBar{
//   BaseHeader({
//     required this.label,
//     this.actions,
//     this.backButton = false,
//     this.leading,
//     this.leadingAppBar,
//   });
//   String label;
//   List<Widget>? actions;
//   Widget? leading;
//   bool backButton;
//   Widget? leadingAppBar;
//   @override
//   Widget build(BuildContext context) {
//     if (backButton) {
//       leadingAppBar = leading ?? const BackButton(color: Colors.white);
//     }
//     return AppBar(
//       leading: leadingAppBar,
//       toolbarHeight: preferredSize.height,
//       title: AutoSizeText(
//         label,
//         style: Get.textTheme.bodyText1!.copyWith(
//           color: Colors.white,
//         ),
//       ),
//       automaticallyImplyLeading: backButton,
//       backgroundColor: Colors.blueAccent,
//       foregroundColor: Colors.blue,
//       centerTitle: true,
//       actions: actions,
//     );
//   }

//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }
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
    this.backgroundColor = Colors.blueAccent,
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
      backgroundColor: backgroundColor,
      centerTitle: isCenterTitle,
    );
  }
}
