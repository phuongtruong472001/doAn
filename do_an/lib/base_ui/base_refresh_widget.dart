import 'package:do_an/base_ui/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base_controller/base_controller_src.dart';

abstract class BaseRefreshWidget<T extends BaseRefreshGetxController>
    extends BaseGetWidget<T> {
  const BaseRefreshWidget({Key? key}) : super(key: key);

  Widget buildPage({
    PreferredSizeWidget? appBar,
    required Widget body,
    double miniumBottom = 0,
    RxBool? isShowSupportCus,
    bool isNeedUpToPage = false,
  }) {
    // Rx<Offset> position = Offset(Get.width - 50, Get.height / 2 + 100).obs;
    // RxBool? isDraging = false.obs;

    return Obx(() => Stack(
          alignment: Alignment.bottomRight,
          children: [
            Scaffold(
              appBar: appBar,
              body: body,
              extendBody: true,
              floatingActionButton: isNeedUpToPage &&
                      controller.showBackToTopButton.value
                  ? Container(
                      padding: EdgeInsets.only(bottom: Get.height / 5),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                            height: 45,
                            width: 45,
                            child: FittedBox(
                              child: FloatingActionButton(
                                heroTag: null,
                                onPressed: () {
                                  controller.scrollControllerUpToTop.animateTo(
                                      0,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastOutSlowIn);
                                },
                                backgroundColor: Colors.white,
                                child: const Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 50,
                                ),
                              ),
                            )),
                      ))
                  : null,
            ),
          ],
        ));
  }
}
