import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/colors.dart';

class ItemCard extends StatelessWidget {
  ItemCard(
    this.icon,
    this.content, {
    Key? key,
    this.title,
    this.subTitle,
    this.color,
    this.isTreeLine = false,
  }) : super(key: key);
  late IconData icon;
  late String content;
  late String? title;
  late String? subTitle;
  late Color? color;
  late bool? isTreeLine;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: AutoSizeText(
        content,
        style: Get.textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: title != null
          ? AutoSizeText(
              title ?? "",
              style: Get.textTheme.bodyMedium!.copyWith(
                color: kSecondaryColor,
              ),
            )
          : null,
      trailing: subTitle != null
          ? AutoSizeText(
              subTitle ?? "",
              style: Get.textTheme.bodyMedium!.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      isThreeLine: isTreeLine ?? false,
    );
  }
}

class TransactionWidget extends StatelessWidget {
  TransactionWidget(this.transaction, {Key? key}) : super(key: key);
  Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(
              horizontal: BorderSide(color: Color(0x22000000), width: .5))),
      child: InkWell(
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.water),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.categoryId.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  if (transaction.description != null &&
                      transaction.description!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        transaction.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            Text(' ${transaction.value.toString()}',
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
