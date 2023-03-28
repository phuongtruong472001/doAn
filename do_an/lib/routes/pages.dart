import 'dart:io';

import 'package:do_an/model/category.dart';
import 'package:do_an/pages/bottom_navigation_bar_home/binding/bottom_navigation_bar_home_binding.dart';
import 'package:do_an/pages/bottom_navigation_bar_home/view/bottom_navigation_bar_home_view.dart';
import 'package:do_an/pages/category/binding/category_binding.dart';
import 'package:do_an/pages/category/view/category_view.dart';
import 'package:do_an/pages/create_transaction/binding/create_transaction_binding.dart';
import 'package:do_an/pages/create_transaction/view/create_transaction_view.dart';
import 'package:do_an/pages/detail_transaction/binding/detail_transaction_binding.dart';
import 'package:do_an/pages/detail_transaction/view/detail_transaction_view.dart';
import 'package:do_an/pages/home/binding/home_binding.dart';
import 'package:do_an/pages/home/view/home_view.dart';
import 'package:get/get.dart';

import 'routes.dart';

class RoutePage {
  static var route = [
    GetPage(
      name: AppRoutes.pageBuilder,
      page: () => const BottomNavigationBarHomePage(),
      binding: BottomNavigationBarHomeBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.createTransaction,
      page: () => const CreateTransactionPage(),
      binding: CreateTransactionBinding(),
    ),
    GetPage(
      name: AppRoutes.detailTransaction,
      page: () => const DetailTransactionPage(),
      binding: DetailTransactionBinding(),
    ),
    GetPage(
      name: AppRoutes.category,
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
    ),
  ];
}
