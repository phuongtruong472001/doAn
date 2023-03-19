import 'package:flutter/material.dart';

import '../base/dimen.dart';

class BuildDivider extends StatelessWidget {
  double height = 10.0;
  double thickness = 1.0;
  double indent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: 1,
    );
  }
}

class BuildDividerDefault extends StatelessWidget {
  double height = 10.0;
  double thickness = 1.0;
  double indent = 0.0;

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 10,
      thickness: 1,
      indent: defaultPadding,
      endIndent: defaultPadding,
    );
  }
}
