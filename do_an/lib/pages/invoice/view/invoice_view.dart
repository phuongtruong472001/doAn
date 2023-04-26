import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/icons.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/model/invoice.dart';
import 'package:do_an/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';

import '../../../base/colors.dart';
import '../controller/invoice_controller.dart';

class InvoicePage extends GetView<InvoiceController> {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(AppString.myInvoice),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.createInvoice);
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: TabBar(
              controller: controller.tabController,
              labelColor: Colors.blue,
              labelStyle: const TextStyle(color: Colors.blue),
              unselectedLabelStyle: const TextStyle(color: Colors.black),
              unselectedLabelColor: Colors.black,
              tabs: const <Widget>[
                Tab(
                  child: Text("Đang diễn ra"),
                ),
                Tab(
                  child: Text("Đã kết thúc"),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: <Widget>[
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => _itemAllowNegative(
                        invoice: controller.listInvoices[index]),
                    itemCount: controller.listInvoices.length,
                  ),
                ),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => _itemNotAllowNegative(
                        invoice: controller.listInvoicesNotComplete[index]),
                    itemCount: controller.listInvoicesNotComplete.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemAllowNegative({required Invoice invoice}) {
    return Column(
      children: [
        InkWell(
          ///Chuyển sang màn chi tiết
          onTap: () {
            Get.toNamed(AppRoutes.detailInvoice, arguments: invoice);
          },
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "${ImageAsset.linkIconCategory}${invoice.categoryID}.png",
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        invoice.categoryName.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hóa đơn tiếp theo là ${invoice.executionTime.toString()}',
                          ),
                          Text(
                            'Hết hạn trong ${invoice.executionTime?.difference(DateTime.now()).inDays} ngày',
                            style: const TextStyle(
                              color: kWrongColor,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kCorrectColor,
                        ),

                        ///Bấm vào nút trả hoặc nhận tiền????
                        onPressed: () {
                          // Trả tiền or nhận tiền ở đây
                        },
                        child: Text(
                          invoice.value!.toVND(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _itemNotAllowNegative({required Invoice invoice}) {
    return Column(
      children: [
        InkWell(
          ///Chuyển sang màn chi tiết
          onTap: () {},
          child: Container(
            height: 50,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://lh3.googleusercontent.com/ogw/AOLn63EEpoN5YZrBVCMb4qlrXIt28dYeYj86NcOcRLq2qA=s32-c-mo',
                  width: 50,
                  height: 50,
                ),
                Text(
                  invoice.categoryName.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
