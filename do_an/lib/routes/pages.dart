import 'package:do_an/pages/bottom_navigation_bar_home/binding/bottom_navigation_bar_home_binding.dart';
import 'package:do_an/pages/bottom_navigation_bar_home/view/bottom_navigation_bar_home_view.dart';
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
    ),
  ];
}
