import 'package:flutter/material.dart';

class BaseHeaderWithBackButton extends StatelessWidget {
  final String content;
  final Widget child;
  final String? title;
  final String? exitTitle;
  final Function? notCheck;
  final bool result = false;
  final Function? function;

  const BaseHeaderWithBackButton(
      {Key? key, 
      required this.content,
      required this.child,
      this.title,
      this.exitTitle,
      this.notCheck,
      this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (notCheck?.call() ?? false) {
          return Future.value(true);
        }
        // !result
        //     ? ShowPopup.showDialogConfirm(
        //         content,
        //         confirm: () => Get.back(),
        //         actionTitle: AppString.confirm.tr,
        //         title: title ?? AppString.notification,
        //         exitTitle: exitTitle ?? AppString.cancel.tr,
        //       )
        //     : function?.call();
        return Future.value(true);
      },
      child: child,
    );
  }
}
