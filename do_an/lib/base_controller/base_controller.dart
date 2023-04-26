import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseGetxController extends GetxController {
  RxBool isShowLoading = false.obs;
  String errorContent = '';
  // BaseRequest baseRequestController = Get.find();

  ///1 CancelToken để huỷ 1 request.
  ///1 màn hình gắn với 1 controller, 1 controller có nhiều requests khi huỷ 1 màn hình => huỷ toàn bộ requests `INCOMPLETED` tại màn hình đó.

  /// Sử dụng một số màn bắt buộc sử dụng loading overlay
  RxBool isLoadingOverlay = false.obs;

  /// Sử dụng cho demo78 phát hành hóa đơn có mã
  RxBool isLoadingOverlayIssue = false.obs;

  /// Sử dụng cho demo78 phát hành thành công hóa đơn
  RxBool isIssueSuccess = false.obs;

  void showIssueSuccess() {
    isIssueSuccess.value = true;
  }

  void hideIssueSuccess() {
    isIssueSuccess.value = false;
  }

  void showLoading() {
    isShowLoading.value = true;
  }

  void hideLoading() {
    isShowLoading.value = false;
  }

  void showLoadingOverlay() {
    isLoadingOverlay.value = true;
  }

  void hideLoadingOverlay() {
    isLoadingOverlay.value = false;
  }

  Future<void> showSnackBar<T>(
    String message, {
    Duration duration = const Duration(seconds: 2),
    Widget? mainButton,
    Color? backgroundColor,
    bool? isSuccess,
  }) async {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isSuccess != null
          ? isSuccess
              ? Colors.green
              : Colors.red
          : Colors.white,
      messageText: Text(
        message.tr,
        style: Get.textTheme.bodyText1!.copyWith(
          color: isSuccess != null ? Colors.white : Colors.black,
        ),
      ),
      message: message.tr,
      mainButton: Row(
        children: [
          if (mainButton != null) mainButton,
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.close,
              color: isSuccess != null ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      duration: message.length > 100 ? 5.seconds : duration,
    ));
  }

  @override
  void onClose() {}

  @override
  void onInit() {}
}
