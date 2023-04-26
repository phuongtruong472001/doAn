import 'package:do_an/base/dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:shimmer/shimmer.dart';

import '../base_controller/base_controller.dart';

abstract class BaseGetWidget<T extends BaseGetxController> extends GetView<T> {
  const BaseGetWidget({Key? key}) : super(key: key);

  Widget buildWidgets();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // tắt tính năng vuốt trái để back lại màn hình trước đó trên iphone
      onWillPop: () async {
        // KeyBoard.hide();
        // await 300.milliseconds.delay();
        return !Navigator.of(context).userGestureInProgress;
      },
      child: buildWidgets(),
    );
  }

  Widget baseShowLoading(WidgetCallback child) {
    return Obx(
      () => controller.isShowLoading.value
          ? const Scaffold(body: Center(child: CupertinoActivityIndicator()))
          : child(),
    );
  }

  Widget baseShimmerLoading(WidgetCallback child, {Widget? shimmer}) {
    return Obx(
      () => controller.isShowLoading.value
          ? shimmer ?? buildShimmerLoading()
          : child(),
    );
  }

  Widget buildLoadingOverlay(WidgetCallback child) {
    return Obx(
      () => Stack(
        children: [
          LoadingOverlayPro(
            progressIndicator: !GetPlatform.isMobile
                ? const CupertinoActivityIndicator(
                    radius: 50,
                  )
                : CupertinoActivityIndicator(),
            isLoading: controller.isLoadingOverlay.value,
            child: child(),
          ),
        ],
      ),
    );
  }

  Widget buildShimmerLoading() {
    const _padding = defaultPadding;
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(horizontal: _padding, vertical: _padding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: ListView.separated(
                  itemBuilder: (context, index) => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 24.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 16.0,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Container(
                                  height: 16.0,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  separatorBuilder: (context, index) => const Divider(
                        height: 15,
                      ),
                  itemCount: 10),
            ),
          ),
        ],
      ),
    );
  }
}
