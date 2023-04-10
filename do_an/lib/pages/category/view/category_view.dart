import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/model/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/icons.dart';
import '../controller/category_controller.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          child: item(
            category: categories[index],
          ),
        ),
        itemCount: categories.length,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: AutoSizeText(
          "Chọn danh mục",
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
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
