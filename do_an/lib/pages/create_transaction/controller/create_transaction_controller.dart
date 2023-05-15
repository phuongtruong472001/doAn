import 'dart:convert';
import 'dart:io';

import 'package:do_an/base_controller/base_controller_src.dart';
import 'package:do_an/database/database.dart';
import 'package:do_an/model/transaction.dart';
import 'package:do_an/pages/home/controller/home_controller.dart';
import 'package:do_an/pages/transaction/controller/transaction_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';

import '../../../base/strings.dart';
import '../../../component/base_bottomsheet.dart';
import '../../../model/fund.dart';
import '../../../model/repeat_time.dart';
import '../../../routes/routes.dart';

class CreateTransactionController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final valueController = MoneyMaskedTextController(
    thousandSeparator: '.',
    precision: 0,
    decimalSeparator: "",
  );
  final descriptionController = TextEditingController();

  final peopleController = TextEditingController();
  Rx<Transaction> transaction = Transaction(executionTime: DateTime.now()).obs;
  var choosedDate = false.obs;
  var selectedDate = DateTime.now().obs;
  DBHelper dbHelper = DBHelper();
  int oldValue = 0;
  Rx<File?> file = Rx<File?>(null);
  TransactionController transactionController =
      Get.isRegistered<TransactionController>()
          ? Get.find<TransactionController>()
          : Get.put(TransactionController());
  HomeController homeController = Get.find<HomeController>();

  void selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    choosedDate.value = true;
    if (picked != null && picked != DateTime.now()) {
      selectedDate.value = picked;
    }
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onReady() {}

  void initData() {
    if (Get.arguments is Transaction) {
      Transaction tran = Get.arguments;
      valueController.text = (tran.value! * (-1)).toString();
      descriptionController.text = tran.description!;
      transaction.value.categoryName = tran.categoryName;
      transaction.value.fundName = tran.fundName;
      selectedDate.value = tran.executionTime!;
      oldValue = tran.value!;
      transaction.value = tran;
    }
  }

  void chooseCategory() {
    Get.toNamed(AppRoutes.category)!.then((value) {
      if (value != null) {
        transaction.update((val) {
          val!.categoryId = value.id;
          val.categoryName = value.name;
          val.isIncrease = value.typeCategory == 5 ? 1 : 0;
        });
      }
    });
  }

  void chooseFund() {
    Get.toNamed(AppRoutes.fund, arguments: true)!.then((value) {
      if (value is Fund) {
        transaction.update((val) {
          val!.fundID = value.id;
          val.fundName = value.name ?? "";
          val.iconFund = value.icon ?? "";
        });
      }
    });
  }

  void chooseEvent() {
    Get.toNamed(AppRoutes.event, arguments: true)!.then((value) {
      if (value != null) {
        transaction.update((val) {
          val!.eventId = value.id;
          val.eventName = value.name;
        });
      }
    });
  }

  Future<void> manageTransaction() async {
    if (transaction.value.isIncrease == 1) {
      transaction.value.value = int.parse(
          valueController.value.text.replaceAll('.', '').replaceAll("đ", ""));
    } else {
      transaction.value.value = int.parse(valueController.value.text
              .replaceAll('.', '')
              .replaceAll("đ", "")) *
          (-1);
    }
    //transaction.value.executionTime = selectedDate.value;
    transaction.value.description = descriptionController.value.text;
    transaction.value.endTime = transaction.value.executionTime;
    if (transaction.value.typeRepeat == 1) {
      if (transaction.value.typeTime == 0) {
        transaction.value.endTime = Jiffy(transaction.value.endTime)
            .add(duration: Duration(days: transaction.value.amount))
            .dateTime;
      } else if (transaction.value.typeTime == 1) {
        transaction.value.endTime = Jiffy(transaction.value.endTime)
            .add(weeks: transaction.value.amount)
            .dateTime;
      } else {
        transaction.value.endTime = Jiffy(transaction.value.endTime)
            .add(months: transaction.value.amount)
            .dateTime;
      }
    }

    if (formKey.currentState!.validate() &&
        transaction.value.categoryId! >= 0 &&
        transaction.value.fundID! >= 0) {
      if (Get.arguments != null) {
        await editTransaction();
      } else {
        await createTransaction();
      }
    } else {
      showSnackBar(
        "Nguồn tiền và danh mục không thể để trống!",
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> createTransaction() async {
    bool status = await dbHelper.addTransaction(transaction.value);
    if (status) {
      Get.back();
      await transactionController.initData();
      await homeController.initData();
    }

    showSnackBar(
      status
          ? AppString.editSuccess("giao dịch")
          : AppString.editFail("giao dịch"),
      backgroundColor: status ? Colors.green : Colors.red,
    );
  }

  Future<void> editTransaction() async {
    await Get.dialog(
      AlertDialog(
        title: const Text("Xác nhận"),
        content: const Text('Bạn có muốn sửa giao dịch này không?'),
        actions: [
          // The "Yes" button
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Huỷ')),
          TextButton(
              onPressed: () async {
                bool status =
                    await dbHelper.editTransaction(transaction.value, oldValue);
                if (status) {
                  await transactionController.initData();
                  await homeController.initData();
                  Get.close(1);
                  Get.back();
                }

                showSnackBar(
                  status
                      ? AppString.editSuccess("giao dịch")
                      : AppString.editFail("giao dịch"),
                  backgroundColor: status ? Colors.green : Colors.red,
                );
              },
              child: const Text('Sửa'))
        ],
      ),
    );
  }

  void selectDateRepeat(BuildContext context) {
    Get.bottomSheet(BottomSheetSelectTime(), isScrollControlled: true)
        .then((value) {
      if (value is RepeatTime) {
        transaction.update((val) {
          val!.executionTime = Jiffy(value.dateTime)
              .add(
                hours: value.timeOfDay!.hour,
                minutes: value.timeOfDay!.minute,
              )
              .dateTime;
          val.typeRepeat = value.typeRepeat;
          val.typeTime = value.typeTime;
          val.isRepeat = value.isRepeat;
          val.amount = value.amount;
        });
      } else {
        Get.delete<BaseBottomSheetController>();
      }
    });
  }

  Future<void> getImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      file.value = File(pickedFile.path);
      List<int> imageBytes = file.value!.readAsBytesSync();
      String base64File = base64Encode(imageBytes);
      transaction.value.imageLink = base64File;
    }
  }

  Uint8List bytesImage(String base64ImageString) {
    return const Base64Decoder().convert(base64ImageString);
  }
}
