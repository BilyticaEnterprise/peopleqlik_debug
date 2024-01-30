// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:peopleqlik_version_1/BusinessLogicModel/Listeners/FileDownloaderListener/file_download_permission.dart';
//
// class DownLoadFile
// {
//   Future<void> downloadFile(BuildContext context) async {
//     Dio dio = Dio();
//     bool checkPermission1 = await CheckFilePermission().askPermission();
//     // print(checkPermission1);
//     if (checkPermission1 == false) {
//       ScaffoldMessenger.of(context).showSnackBar(snackBar)
//     }
//     else
//       {
//         if (checkPermission1 == true) {
//           String dirloc = "";
//           if (Platform.isAndroid) {
//             dirloc = "/sdcard/download/";
//           } else {
//             dirloc = (await getApplicationDocumentsDirectory()).path;
//           }
//
//           var randid = random.nextInt(10000);
//
//           try {
//             FileUtils.mkdir([dirloc]);
//             await dio.download(imgUrl, dirloc + randid.toString() + ".jpg",
//                 onReceiveProgress: (receivedBytes, totalBytes) {
//                   setState(() {
//                     downloading = true;
//                     progress =
//                         ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
//                   });
//                 });
//           } catch (e) {
//             print(e);
//           }
//
//           setState(() {
//             downloading = false;
//             progress = "Download Completed.";
//             path = dirloc + randid.toString() + ".jpg";
//           });
//         } else {
//           setState(() {
//             progress = "Permission Denied!";
//             _onPressed = () {
//               downloadFile();
//             };
//           });
//         }
//       }
//
//   }
//   void goToSettings(BuildContext context)
//   {
//     Future.delayed(const Duration(milliseconds: 100),() async {
//       SlidingPanelData slidingPanelData = Provider?.of<SlidingPanelData>(context,listen: false);
//       slidingPanelData.currentPage = SliderWidgetEnum.permission;
//       slidingPanelData.notifyListener();
//       await slidingPanelData.panelController?.open();
//     });
//
//   }
//   Future<void> failedPermission(BuildContext context)
//   async {
//     Future.delayed(const Duration(milliseconds: 100),() async {
//       SlidingPanelData slidingPanelData = Provider?.of<SlidingPanelData>(context,listen: false);
//       slidingPanelData.currentPage = SliderWidgetEnum.permission;
//       slidingPanelData.notifyListener();
//       await slidingPanelData.panelController?.open();
//     });
//   }
// }