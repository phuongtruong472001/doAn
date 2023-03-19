// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:do_an/base/strings.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// enum ShowPopupType {
//   showDialog,
//   showDialogNotification,
//   showErrorMessage,
//   showDialogConfirm
// }

// abstract class ShowPopup {
//   // String content;
//   // Function? confirm;
//   // String actionTitle;
//   // bool isActiveBack = true;
//   // String title;
//   // String exitTitle;
//   // Function? cancelFunc;
//   // bool isAutoCloseDialog = false;
//   Widget build(
//     String content,
//     Function? confirm,
//     String actionTitle,
//     bool isActiveBack,
//     String title,
//     String exitTitle,
//     Function? cancelFunc,
//     bool isAutoCloseDialog,
//   );
//   // ShowPopup({
//   //   this.content = "",
//   //   this.confirm,
//   //   this.actionTitle = "",
//   //   this.isActiveBack = false,
//   //   this.title = AppString.notification,
//   //   this.exitTitle = AppString.cancel,
//   //   this.cancelFunc,
//   //   this.isAutoCloseDialog = false,
//   // });
//   // factory ShowPopup.showDialog() {
//   //   return ShowPopup(
//   //     actionTitle: '',
//   //     cancelFunc:()=> Get.back(),
//   //     exitTitle: '',
//   //     confirm: () {},
//   //     content: '',
//   //     title: '',
//   //     isActiveBack: true,
//   //     isAutoCloseDialog: true,
//   //   );
//   // }

// }

// class ShowDialogNotification extends ShowPopup {
//   @override
//   Widget build(
//       String content,
//       Function? confirm,
//       String actionTitle,
//       bool isActiveBack,
//       String title,
//       String exitTitle,
//       Function? cancelFunc,
//       bool isAutoCloseDialog) {
//     return Dialog(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.only(top: 15, bottom: 10),
//               child: Icon(
//                 _buildIconDialog(content),
//                 size: AppDimens.sizeDialogNotiIcon,
//                 color: Colors.blueAccent,
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(15.0),
//               constraints: const BoxConstraints(maxHeight: 200),
//               child: SingleChildScrollView(
//                 child: Text(
//                   content,
//                   style: TextStyle(fontSize: AppDimens.fontMedium()),
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.clip,
//                   textScaleFactor: 1,
//                 ),
//               ),
//             ),
//             const Divider(
//               height: 1,
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: _baseButton(
//                 function,
//                 nameAction.tr,
//                 colorText: AppColors.colorBlueAccent,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
