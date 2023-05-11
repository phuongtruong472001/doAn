import 'package:do_an/base/dimen.dart';
import 'package:do_an/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(paddingSmall),
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    foregroundColor: Colors.blue,
                  ),
                  title: Text(
                    controller.box.read("name"),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(
                          AppRoutes.invoice,
                          arguments: true,
                        ),
                        child: menuMet(
                            "Hoá đơn", Icons.location_on_outlined, Colors.purple),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(
                          AppRoutes.createTransaction,
                          arguments: true,
                        ),
                        child: menuMet("Giao dịch định kỳ",
                            Icons.settings_outlined, Colors.orange),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(
                          AppRoutes.event,
                        ),
                        child: menuMet("Sự kiện", Icons.event, Colors.orange),
                      ),
                      menuMet("Contact", Icons.call_outlined, Colors.blue)
                    ],
                  ),
                ),
                const Spacer(),
                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //       color: const Color.fromARGB(255, 255, 226, 236),
                //       borderRadius: BorderRadius.circular(5)),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: const [
                //       Text("Log out",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               color: Colors.redAccent)),
                //     ],
                //   ),
                // ).paddingAll(defaultPadding),
              ],
            )));
  }

  Widget menuMet(
    String content,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 10, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: color),
                  child: Icon(icon, color: Colors.white)),
              Text(content,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}
