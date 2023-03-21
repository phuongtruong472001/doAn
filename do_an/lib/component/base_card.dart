import 'package:do_an/base/colors.dart';
import 'package:flutter/material.dart';

import '../base/dimen.dart';

class CardBase extends StatelessWidget {
  Widget child;
  Color? colorBorder;
  Color? backgroundColor;
  BorderRadiusGeometry? borderRadius;
  bool getShadow;

  CardBase(
    this.child, {Key? key, 
    this.backgroundColor,
    this.borderRadius,
    this.getShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? kPrimaryLightColor,
        borderRadius: borderRadius ??
            const BorderRadius.all(Radius.circular(borderRadiusSmall)),
        border: Border.all(
          color: colorBorder ?? Colors.white,
        ),
        boxShadow: getShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  blurRadius: 3,
                ),
              ]
            : [],
      ),
      child: child,
    );
  }
}
