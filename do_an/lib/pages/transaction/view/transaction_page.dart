import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../controller/transaction_controller.dart';

const int AN_UONG = 0;
// ignore: constant_identifier_names
const int LUONG = 1;
// ignore: constant_identifier_names
const int TRA_NO = 2;

class TracsactionPage extends GetView<TracsactionController> {
  const TracsactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TracsactionController());
    var listItem = [
      spending(AN_UONG, '', '5,000,000'),
      spending(LUONG, '', '8,000,000'),
      spending(TRA_NO, 'Trả nợ cho ai đó', '10,000,000'),
      spending(AN_UONG, '', '200,000')
    ];
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Column(
                          children: [
                            Column(
                              children: const [
                                AutoSizeText(AppString.balance),
                                Text(
                                  '-8,700,000 đ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 200, 200, 200),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.public,
                                    color: kPrimaryColor,
                                  ),
                                  AutoSizeText(
                                    AppString.total,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Row(children: [
                            Container(
                                margin: const EdgeInsets.all(5),
                                child: const Icon(Icons.search)),
                            Container(
                                margin: const EdgeInsets.all(5),
                                child: const Icon(Icons.more_vert)),
                          ]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: TabBar(
                        tabs: const [
                          AutoSizeText(AppString.lastMonth),
                          AutoSizeText(AppString.thisMonth),
                          AutoSizeText(AppString.future),
                        ],
                        onTap: (value) => controller.onTapped(value),
                        labelColor: kPrimaryColor,
                        unselectedLabelColor: kSecondaryColor,
                      ),
                    )
                  ],
                )),
            ListView.builder(
              itemBuilder: (context, index) => listItem[index],
              itemCount: listItem.length,
              shrinkWrap: true,
            ),
          ],
        ).paddingAll(defaultPadding),
      ),
    );
  }

  Widget bottomMenu(IconData icon, String content, bool choosed) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Icon(
              icon,
              color: choosed ? Colors.black : Colors.grey,
            ),
            Text(
              content,
              style: TextStyle(color: choosed ? Colors.black : Colors.grey),
            )
          ],
        ));
  }

  Widget moneyOfDate(String thu, int day, int month, int year, String money) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 1.0, color: Color.fromARGB(128, 0, 0, 0)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.all(5),
                    child: Text(
                      '$day',
                      style: const TextStyle(fontSize: 40),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(thu),
                    Text(
                      'tháng $month $year',
                      style: const TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 113, 113, 113)),
                    )
                  ],
                )
              ]),
          Text(
            money,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget spending(int status, String content, String money) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.detailTransaction),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      // image: DecorationImage(
                      //     image: AssetImage(
                      //         'assets/${status == AN_UONG ? "anuong.jpg" : status == LUONG ? "luong.jpg" : "trano.jpg"}')),
                      shape: BoxShape.circle),
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0),
                        color: Colors.red,
                        // image: const DecorationImage(
                        //     image: AssetImage('assets/status.jpg')),
                        shape: BoxShape.circle),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status == AN_UONG
                        ? "Ăn uống"
                        : status == LUONG
                            ? "Lương"
                            : "Trả nợ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    content,
                    style: const TextStyle(
                        fontSize: 11, color: Color.fromARGB(255, 113, 113, 113)),
                  )
                ],
              )
            ],
          ),
          Text(
            money,
            style: TextStyle(
                color: status == LUONG ? Colors.blue : Colors.red,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
