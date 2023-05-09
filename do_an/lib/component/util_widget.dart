import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UtilWidget {
  static PreferredSizeWidget buildBaseBackgroundAppBar({
    required Widget title,
    List<Widget>? actions,
    Widget? leading,
    bool backButton = true,
  }) {
    Widget? leadingAppBar;
    if (backButton) {
      leadingAppBar = leading ??
          const BackButton(
            color: Colors.white,
          );
    }
    return AppBar(
      leading: leadingAppBar,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      title: title,
      automaticallyImplyLeading: backButton,
      backgroundColor: Colors.blue[400],
      centerTitle: true,
      actions: actions,
    );
  }

  static Widget buildSmartRefresher({
    required RefreshController refreshController,
    required Widget child,
    ScrollController? scrollController,
    Function()? onRefresh,
    Function()? onLoadMore,
    bool enablePullUp = false,
  }) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(Get.context!).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: enablePullUp,
        scrollController: scrollController,
        header: const MaterialClassicHeader(),
        controller: refreshController,
        onRefresh: onRefresh,
        onLoading: onLoadMore,
        footer: buildSmartRefresherCustomFooter(),
        child: child,
      ),
    );
  }

  static Widget buildSmartRefresherCustomFooter() {
    return CustomFooter(
      builder: (context, mode) {
        if (mode == LoadStatus.loading) {
          return const CupertinoActivityIndicator();
        } else {
          return const Opacity(
            opacity: 0.0,
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  static Widget buildSearch({
    required TextEditingController textEditingController,
    String hintSearch = AppString.hintSearch,
    required Function function,
    required RxBool isClear,
    Color? hintColor,
    Color? borderColor,
    bool? autofocus,
    Color? backgroundColor,
    bool isOnline = true,
  }) {
    return UtilWidget.buildTextInput(
      height: 40.0,
      controller: textEditingController,
      hintText: hintSearch,
      textColor: Colors.black,
      hintColor: Colors.grey,
      borderColor: Colors.grey,
      autofocus: autofocus,
      fillColor: backgroundColor ?? Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      onChanged: (v) {
        onTextChange(
          () {
            function();
            isClear.value = textEditingController.text.isNotEmpty;
          },
          isOnline: isOnline,
        );
      },
      prefixIcon: const Icon(
        Icons.search,
        color: Colors.black,
        size: 20,
      ),
      suffixIcon: Obx(() => Visibility(
            visible: isClear.value,
            child: IconButton(
              onPressed: () {
                textEditingController.clear();
                isClear.value = false;
                function();
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.grey,
              ),
            ).paddingOnly(bottom: paddingSmall),
          )),
    ).paddingSymmetric(vertical: paddingSmall);
  }

  static Widget buildTextInput({
    var height,
    Color? textColor,
    String? hintText,
    Color? hintColor,
    Color? fillColor,
    TextEditingController? controller,
    Function(String)? onChanged,
    Function()? onTap,
    Widget? prefixIcon,
    Widget? suffixIcon,
    FocusNode? focusNode,
    Color? borderColor,
    bool? autofocus,
    BorderRadius? borderRadius,
  }) {
    return SizedBox(
      height: height,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        focusNode: focusNode,
        autofocus: autofocus ?? true,
        style: TextStyle(
          color: textColor ?? Colors.black,
        ),
        decoration: InputDecoration(
            hoverColor: Colors.white,
            prefixIcon: prefixIcon,
            fillColor: fillColor,
            filled: true,
            suffixIcon: suffixIcon,
            hintText: hintText ?? "",
            hintStyle:
                TextStyle(color: hintColor ?? Colors.black, fontSize: 12),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.grey),
              borderRadius: borderRadius ??
                  const BorderRadius.all(
                    Radius.circular(5),
                  ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.grey),
              borderRadius: borderRadius ??
                  const BorderRadius.all(
                    Radius.circular(5),
                  ),
            ),
            contentPadding: const EdgeInsets.all(5)),
        onChanged: onChanged,
        onTap: onTap,
        controller: controller,
      ),
    );
  }

  static buildAppBarTitle(String title,
      {bool? textAlignCenter, Color? textColor}) {
    textAlignCenter = textAlignCenter ?? GetPlatform.isAndroid;
    return AutoSizeText(
      title.tr,
      textAlign: textAlignCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        color: textColor ?? Colors.black,
      ),
      maxLines: 2,
    );
  }

  static Future<DateTime?> buildDateTimePicker({
    required DateTime dateTimeInit,
    DateTime? minTime,
    DateTime? maxTime,
  }) async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: Get.context!,
      height: 310,
      locale: const Locale('vi', 'VN'),
      initialDate: dateTimeInit,
      firstDate: minTime ?? DateTime.utc(DateTime.now().year - 10),
      lastDate: maxTime,
      // barrierDismissible: true,
      theme: ThemeData(
        primaryColor: Colors.blue,
        dialogBackgroundColor: Colors.blue,
        primarySwatch: Colors.deepOrange,
        disabledColor: Colors.grey,
        textTheme: TextTheme(
          bodySmall: Get.textTheme.bodyLarge!.copyWith(color: Colors.grey),
          bodyMedium: Get.textTheme.bodyLarge,
        ),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        paddingMonthHeader: const EdgeInsets.all(15),
        textStyleMonthYearHeader: Get.textTheme.bodyLarge,
        colorArrowNext: Colors.grey,
        colorArrowPrevious: Colors.grey,
        textStyleButtonNegative:
            Get.textTheme.bodyLarge!.copyWith(color: Colors.grey),
        textStyleButtonPositive:
            Get.textTheme.bodyLarge!.copyWith(color: Colors.blue),
      ),
    );
    return newDateTime;
  }

  static Widget buildButton(
    String title,
    Function() func, {
    Color? textColor,
    Color? color,
    double? width,
    double? height,
    double? borderRadius,
    double? padding,
    double? paddingText,
    double? fontSize,
    TextAlign? textAlign,
    AlignmentGeometry? alignment,
  }) {
    return GestureDetector(
      onTap: func,
      child: SizedBox(
        width: width ?? double.infinity,
        height: height ?? 50,
        child: Container(
          width: width ?? Get.width,
          height: height ?? Get.height,
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
          ),
          child: Center(
            child: AutoSizeText(title),
          ),
        ),
      ),
    );
  }
}

final _debouncer = Debouncer(seconds: 1);
onTextChange(Function function, {bool isOnline = true}) {
  if (isOnline) {
    _debouncer.run(() => function());
  } else {
    function();
  }
}

class Debouncer {
  final int seconds;
  Timer? _timer;

  Debouncer({required this.seconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: seconds), action);
  }
}
