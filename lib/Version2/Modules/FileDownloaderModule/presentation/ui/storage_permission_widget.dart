// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:peopleqlik_debug/Version1/views/BottomBarPages/Announcements/AnnouncementPanels/permission_page.dart';
// import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/presentation/bloc/check_storage_permission_bloc.dart';
// import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/utils/storage_permission_enums.dart';
// import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
// import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
//
// class StoragePermissionWidget extends StatelessWidget {
//   final Widget child;
//   const StoragePermissionWidget({required this.child,super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ExtendedMultiBlocProvider(
//       providers: [
//         BlocProvider<StoragePermissionBloc>(create: (_) => StoragePermissionBloc(StoragePermissionEnum.nothing),)
//       ],
//       builder: (context) {
//         return _BodyData(child: child,);
//       }
//     );
//   }
// }
//
// class _BodyData extends StatefulWidget {
//   final Widget child;
//   const _BodyData({required this.child,super.key});
//
//   @override
//   State<_BodyData> createState() => _BodyDataState();
// }
//
// class _BodyDataState extends State<_BodyData> {
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       BlocProvider.of<StoragePermissionBloc>(context,listen: false).checkPermission();
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<StoragePermissionBloc,StoragePermissionEnum>(
//       listener: (context, data){},
//       builder: (context, data) {
//         if (data == StoragePermissionEnum.success) {
//           return widget.child;
//         }
//         else if (data == StoragePermissionEnum.goToSettings) {
//           return StoragePermission(widget.panelController);
//         }
//         else if (data == StoragePermissionEnum.permission) {
//           return StoragePermission(widget.panelController);
//         }
//         else
//         {
//           return const CircularIndicatorCustomized();
//         }
//       }
//     );
//   }
// }
