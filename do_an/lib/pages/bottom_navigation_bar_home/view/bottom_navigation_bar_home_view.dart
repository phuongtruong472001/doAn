import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/bottom_navigation_bar_home_controller.dart';

class BottomNavigationBarHomePage
    extends GetView<BottomNavigationBarHomeController> {
  const BottomNavigationBarHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavigationBarHomeController());
    final iconList = <IconData>[
      Icons.brightness_5,
      Icons.brightness_4,
      Icons.brightness_6,
      Icons.brightness_7,
    ];
    return Scaffold(
      body: buildBody(controller.indexTab.value),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? kPrimaryColor : kSecondaryColor;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  "brightness $index",
                  maxLines: 1,
                  style: TextStyle(color: color),
                  // group: autoSizeGroup,
                ),
              )
            ],
          );
        },
        backgroundColor: kPrimaryLightColor,
        activeIndex: controller.indexTab.value,
        splashColor: kPrimaryLightColor,
        //notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => controller.onTapped(index),
        //hideAnimationController: _hideBottomBarAnimationController,
        shadow: BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  buildBody(int value) {
    return Center(
      child: Text(
        "$value",
      ),
    );
  }
}
