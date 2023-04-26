import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';

import '../../../base/colors.dart';
import '../controller/detail_invoice_controller.dart';

class DetailInvoicePage extends GetView<DetailInvoiceController> {
  const DetailInvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close)),
          actions: [
            IconButton(
              onPressed: () {
                ///Chỉnh sửa hóa đơn
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                ///Xóa hóa đơn
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://lh3.googleusercontent.com/ogw/AOLn63EEpoN5YZrBVCMb4qlrXIt28dYeYj86NcOcRLq2qA=s32-c-mo',
                  width: 50,
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => AutoSizeText(
                        controller.invoice.value.categoryName ?? "",
                      ),
                    ),
                    Obx(
                      () => AutoSizeText(
                        controller.invoice.value.value.toString().toVND(),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 50,
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Hóa đơn tiếp theo là ${controller.invoice.value.executionTime}',
                          ),
                          AutoSizeText(
                            'Hết hạn trong ${controller.invoice.value.executionTime?.difference(DateTime.now()).inDays} ngày',
                            style: const TextStyle(
                              color: kWrongColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.network(
                  'https://lh3.googleusercontent.com/ogw/AOLn63EEpoN5YZrBVCMb4qlrXIt28dYeYj86NcOcRLq2qA=s32-c-mo',
                  width: 50,
                  height: 50,
                ),
                AutoSizeText(controller.invoice.value.fundName ?? ""),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  ///Trả hoặc nhận tiền ở đây???
                  onPressed: () {},
                  child: AutoSizeText(
                    'Thanh toán ${controller.invoice.value.value.toVND()} ₫',
                  ),
                ),
                TextButton(
                  ///Đánh dấu giao dịch hoàn tất???
                  onPressed: () {},
                  child: const AutoSizeText(
                    'ĐÁNH DẤU HOÀN TẤT',
                    style: TextStyle(
                      color: kCorrectColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kCorrectColor,
              ),

              ///Chuyển qua danh sách giao dịch
              onPressed: () {},
              child: const AutoSizeText(
                'DANH SÁCH GIAO DỊCH',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: defaultPadding),
      ),
    );
  }
}
