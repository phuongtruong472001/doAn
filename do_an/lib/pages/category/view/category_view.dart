import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/model/category.dart';
import 'package:flutter/material.dart';

import '../../../base/icons.dart';
import '../../../base_ui/base_search_appbar_widget.dart';
import '../../../component/util_widget.dart';
import '../controller/category_controller.dart';

class CategoryPage extends BaseSearchAppBarWidget<CategoryController> {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget buildWidgets() {
    return baseShimmerLoading(
      () => buildPage(
        backButton: true,
        showWidgetEmpty: true,
        buildBody: UtilWidget.buildSmartRefresher(
          refreshController: controller.refreshController,
          onRefresh: controller.onRefresh,
          onLoadMore: controller.onLoadMore,
          enablePullUp: true,
          child: ListView.builder(
            itemBuilder: (context, index) => Card(
              child: item(
                category: controller.rxList[index],
              ),
            ),
            itemCount: controller.rxList.length,
          ),
        ),
      ),
    );
  }

  Widget item({required Category category}) {
    return GestureDetector(
      onTap: () => controller.onTapItem(category),
      child: ListTile(
        title: AutoSizeText(category.name ?? ""),
        leading: Image.asset(
          "${ImageAsset.linkIconCategory}${category.id}.png",
          width: 80,
          height: 50,
        ),
      ),
    );
  }
}
