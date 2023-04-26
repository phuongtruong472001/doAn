import 'package:do_an/component/util_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base_controller/base_page_search_controller.dart';
import 'base_refresh_widget.dart';

abstract class BasePageSearchWidget<T extends BasePageSearchController>
    extends BaseRefreshWidget<T> {
  const BasePageSearchWidget({Key? key}) : super(key: key);
  Widget buildAppBarScroll({
    required List<Widget> listSliverAppBar,
    required Widget widgetBody,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        Get.focusScope!.unfocus();
      },
      child: NestedScrollView(
        physics: const PageScrollPhysics(),
        controller: controller.scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return listSliverAppBar;
        },
        body: widgetBody,
      ),
    );
  }

  /// list sliver appbar.
  ///
  ///  `titleAppBar` chuỗi tiêu đề trên appbar.
  ///
  ///  `hintTextSearch` chuỗi tiêu đề ẩn trên inputtext.
  List<Widget> listSliverAppBar({
    required String titleAppBar,
    required String hintTextSearch,
    Widget? widgetDesc,
    List<Widget>? actions,
  }) {
    return <Widget>[
      Obx(
        () => SliverAppBar(
          backgroundColor: Colors.blue[400],
          floating: false,
          pinned: false,
          elevation: 0,
          automaticallyImplyLeading: controller.isScrollToTop(),
          actions: actions,
          flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return FlexibleSpaceBar(
              centerTitle: GetPlatform.isAndroid,
              collapseMode: CollapseMode.parallax,
              title: UtilWidget.buildAppBarTitle(titleAppBar),
            );
          }),
        ),
      ),
    ];
  }
}
