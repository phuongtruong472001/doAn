import 'package:do_an/base/strings.dart';
import 'package:do_an/base_ui/base_widget.dart';
import 'package:do_an/component/util_widget.dart';
import 'package:flutter/material.dart';

import '../base_controller/base_search_appbar_controller.dart';

abstract class BaseSearchAppBarWidget<T extends BaseSearchAppbarController>
    extends BaseGetWidget<T> {
  const BaseSearchAppBarWidget({Key? key}) : super(key: key);

  Widget buildPage({
    required Widget buildBody,
    String? titleEmpty,
    String? titleBotton,
    String? hintSearch,
    var actionButtonOnpress,
    bool backButton = true,
    Widget actionExtra = const SizedBox(),
    bool showAppBar = true,
    Widget? buildWidgetEmpty,
    bool showWidgetEmpty = true,
    Function? function,
  }) {
    return Scaffold(
      appBar: showAppBar
          ? UtilWidget.buildBaseBackgroundAppBar(
              title: UtilWidget.buildSearch(
                textEditingController: controller.textSearchController,
                hintSearch: hintSearch ?? AppString.hintSearch,
                function: () async {
                  controller.isSearch.value =
                      controller.textSearchController.text.isNotEmpty;
                  await controller.functionSearch();
                },
                isClear: controller.isClear,
                autofocus: false,
              ),
              backButton: backButton,
              actions: [actionExtra]
            )
          : null,
      body: baseShimmerLoading(
        () => _buildBody(
          buildWidgetEmpty,
          titleEmpty,
          titleBotton,
          actionButtonOnpress,
          buildBody,
          showWidgetEmpty,
        ),
      ),
      floatingActionButton: function != null
          ? FloatingActionButton(
              heroTag: "btnAdd",
              onPressed: () => function.call(),
              backgroundColor: Colors.green,
              child: const Icon(
                Icons.add,
              ),
            )
          : null,
    );
  }

  Widget _buildBody(
    Widget? buildWidgetEmpty,
    String? titleEmpty,
    String? titleButton,
    actionButtonOnpress,
    Widget buildBody,
    bool showWidgetEmpty,
  ) {
    return Align(
      alignment: Alignment.topLeft,
      child: controller.rxList.isEmpty && showWidgetEmpty
          ? (!controller.isSearch.value
              ? _buildViewEmpty(
                  buildWidgetEmpty,
                  titleEmpty,
                  titleButton,
                  actionButtonOnpress,
                )
              : Column(
                  children: [
                    buildWidgetEmpty ??
                        const Expanded(
                          child: Center(
                            child: Text("không tìm kiếm"),
                          ),
                        ),
                  ],
                ))
          : buildBody,
    );
  }

  Container _buildToTop() {
    return Container(
      padding: const EdgeInsets.only(bottom: 50),
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            controller.scrollControllerUpToTop.animateTo(0,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn);
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(
            Icons.keyboard_arrow_up,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildViewEmpty(Widget? buildWidgetEmpty, String? titleEmpty,
      String? titleButton, actionButtonOnpress) {
    return const Center(
      child: Text("không tìm kiếm"),
    );
  }
}
