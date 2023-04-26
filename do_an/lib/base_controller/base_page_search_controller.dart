import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_refresh_controller.dart';

abstract class BasePageSearchController<T> extends BaseRefreshGetxController {
  RxDouble scrollOffset = 0.0.obs;

  double appBarHeight = 70.0;

  /// Controller của input search.
  TextEditingController searchController = TextEditingController();

  ScrollController scrollController = ScrollController();

  int pageNumber = 1;

  /// Kiểm tra vị trí scroll ở vị trí đầu.
  bool isScrollToTop() {
    return scrollOffset <= (appBarHeight - kToolbarHeight / 2);
  }
}
