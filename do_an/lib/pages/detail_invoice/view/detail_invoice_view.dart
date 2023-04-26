import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/colors.dart';
import '../controller/detail_invoice_controller.dart';

class DetailInvoicePage extends GetView<DetailInvoiceController> {
  const DetailInvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      controller.transaction.value.categoryName,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Obx(
                    () => AutoSizeText(
                      controller.transaction.value.value.toString().toVND(),
                      style: const TextStyle(fontSize: 32),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Hóa đơn tiếp theo là ${controller.transaction.value.executionTime.toString()}',
                      ),
                      AutoSizeText(
                        'Hết hạn trong ${controller.transaction.value.executionTime?.difference(DateTime.now()).inDays} ngày',
                        style: const TextStyle(
                          color: kWrongColor,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      ///Nhắc lại vào hạn trước đó 1 ngày, làm gì đó ở đây em Zuy không biết
                    },
                    child: AutoSizeText(
                      'NHẮC LẠI VÀO ${DateFormat('dd/MM/yyyy').format(controller.transaction.value.executionTime!.subtract(const Duration(days: 1)))}',
                      style: const TextStyle(
                        color: kCorrectColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
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
              AutoSizeText(controller.transaction.value.fundName),
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
                  '${controller.transaction.value.isIncrease == 0 ? 'TRẢ' : 'NHẬN'} ${controller.transaction.value.value.toVND()} ₫',
                  style: const TextStyle(
                    color: kCorrectColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
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
      ),
    );
  }
}
