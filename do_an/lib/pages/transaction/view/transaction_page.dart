import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/item_card.dart';
import '../../../routes/routes.dart';
import '../controller/transaction_controller.dart';

class TracsactionPage extends GetView<TransactionController> {
  const TracsactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: SafeArea(
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
              Obx(
                () => ListView.builder(
                  itemBuilder: (context, index) =>
                      TransactionWidget(controller.transactions[index]),
                  itemCount: controller.transactions.length,
                  shrinkWrap: true,
                ),
              ),
            ],
          ).paddingAll(defaultPadding),
        ),
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
}
