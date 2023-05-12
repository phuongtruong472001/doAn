import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseButton extends StatelessWidget {
  BaseButton(this.title, this.onpressButton, {Key? key}) : super(key: key);
  String title;
  Function onpressButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: () => onpressButton.call(),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    title,
                    style:
                        Get.textTheme.bodyText1!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).paddingAll(paddingSmall);
  }
}
