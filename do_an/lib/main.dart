import 'package:do_an/base/theme.dart';
import 'package:do_an/pages/bottom_navigation_bar_home/view/bottom_navigation_bar_home_view.dart';
import 'package:do_an/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: const BottomNavigationBarHomePage(),
      locale: const Locale('vi', 'VN'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: RoutePage.route,
    );
  }
}
