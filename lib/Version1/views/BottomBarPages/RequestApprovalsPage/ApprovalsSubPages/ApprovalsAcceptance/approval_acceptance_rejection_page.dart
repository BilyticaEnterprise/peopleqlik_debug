// import 'package:flutter/material.dart';
// import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
// import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_accept_listener.dart';
// import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
// import 'package:peopleqlik_debug/Version1/models/ApprovalsModel/approval_detail_mapper.dart';
// import 'package:peopleqlik_debug/Version1/models/ApprovalsModel/get_approvals_detail_model.dart';
// import 'package:peopleqlik_debug/Version1/models/ApprovalsModel/get_approvals_list.dart';
// import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
// import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
// import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
// import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
// import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
// import 'package:peopleqlik_debug/configs/colors.dart';
// import 'package:peopleqlik_debug/utils/date_formats.dart';
// import 'package:peopleqlik_debug/configs/fonts.dart';
// import 'package:peopleqlik_debug/utils/hide_keyboard.dart';
// import 'package:peopleqlik_debug/configs/language_codes.dart';
// import 'package:peopleqlik_debug/utils/screen_sizes.dart';
// import 'package:peopleqlik_debug/utils/strings.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../../../Version1/models/ApprovalsModel/approval_result_set_data.dart';
// import '../../../../../../configs/get_assets.dart';
// import '../../../../../../utils/Appbars/app_bar.dart';
// import 'package:peopleqlik_debug/utils/BottomSheetUi/bottom_sheet_ui.dart';
// import 'AcceptancePanels/approval_body_panel.dart';
// import 'CommonWidgets/approval_list_widget.dart';
// import 'CommonWidgets/call_bottom_sheet_for_remarks.dart';
//
// class ApprovalAcceptanceRejectionPage extends StatefulWidget {
//   const ApprovalAcceptanceRejectionPage({Key? key}) : super(key: key);
//
//   @override
//   State<ApprovalAcceptanceRejectionPage> createState() => _ApprovalAcceptanceRejectionPageState();
// }
//
// class _ApprovalAcceptanceRejectionPageState extends State<ApprovalAcceptanceRejectionPage> {
//   ApprovalResultSetData? approvalResultSet;
//
//   @override
//   Widget build(BuildContext context) {
//     approvalResultSet = ModalRoute.of(context)!.settings.arguments as ApprovalResultSetData;
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<ApprovalsDetailCollector>(create: (_) => ApprovalsDetailCollector()),
//         ChangeNotifierProvider<ApprovalsAcceptRejectCollector>(create: (_) => ApprovalsAcceptRejectCollector())
//       ],
//       child: GestureDetector(
//         onTap: (){HideShowKeyboard.hide(context);},
//         child: Scaffold(
//             backgroundColor: const Color(MyColor.colorWhite),
//             body: NestedScrollView(
//               headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//                 return <Widget>[
//                   SliverAppBar(
//                       automaticallyImplyLeading: false,
//                       pinned: false,
//                       floating: true,
//                       backgroundColor: const Color(MyColor.colorWhite),
//                       snap: true,
//                       elevation: 2,
//                       titleSpacing: 0,
//                       title: AppBarWidget("${CallLanguageKeyWords.get(context, LanguageCodes.announcementAppBar)}")
//                   ),
//                 ];
//               },
//               body: Consumer<CheckInternetConnection>(
//                   builder: (context,data,child) {
//                     if(data.internetConnectionEnum == InternetConnectionEnum.available)
//                     {
//                       return BodyData(approvalResultSet);
//                     }
//                     else
//                     {
//                       return NotAvailable(GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
//                     }
//                   }
//               ),
//             ),
//         ),
//       ),
//     );
//   }
// }
// class BodyData extends StatefulWidget {
//   final ApprovalResultSetData? approvalResultSet;
//   const BodyData(this.approvalResultSet, {Key? key}) : super(key: key);
//
//   @override
//   _BodyDataState createState() => _BodyDataState();
// }
//
// class _BodyDataState extends State<BodyData> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Provider.of<ApprovalsDetailCollector>(context,listen: false).approvalDetailMapper = widget.approvalResultSet?.approvalDetailMapper;
//       Provider.of<ApprovalsDetailCollector>(context,listen: false).start(context);
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Consumer<ApprovalsDetailCollector>(
//       builder: (context,data,child) {
//         if(data.apiStatus == ApiStatus.done)
//           {
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
//                     child: Text(
//                       '${CallLanguageKeyWords.get(context, LanguageCodes.ApprovalDetails)}',
//                       style: GetFont.get(
//                           context,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 2.2,
//                           color: MyColor.colorBlack
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: ScreenSize(context).heightOnly( 1),),
//                   ListView.separated(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly( 2)),
//                       itemBuilder: (context,index)
//                       {
//                         return ListBodyOfDetail(data.getApprovalDetailResultSet?.leaveDetail?[index]);
//                       },
//                       separatorBuilder: (context,index){
//                         return SizedBox(height: ScreenSize(context).heightOnly( 2),);
//                       },
//                       itemCount: data.getApprovalDetailResultSet?.leaveDetail?.length??0
//                   ),
//                   if(data.getApprovalDetailResultSet?.approvalHistory!=null&&data.getApprovalDetailResultSet!.approvalHistory!.isNotEmpty&&data.approvalsList!=null&&data.approvalsList!.isNotEmpty)...
//                   [
//                     Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
//                       child: Text(
//                         '${CallLanguageKeyWords.get(context, LanguageCodes.ApprovalHistory)}',
//                         style: GetFont.get(
//                             context,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 2.2,
//                             color: MyColor.colorBlack
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: ScreenSize(context).heightOnly( 1),),
//                     ApprovalListWidget(data.approvalsList)
//                   ],
//                   if(widget.approvalResultSet?.show == true)...[
//                     SizedBox(height: ScreenSize(context).heightOnly( 2),),
//                     ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.announcementReject)}',buttonColor: MyColor.colorBlack,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: rejectPressed,),
//                     SizedBox(height: ScreenSize(context).heightOnly( 2),),
//                     ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.approvalBodyPanelButton2)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: approvePressed,),
//                     SizedBox(height: ScreenSize(context).heightOnly( 6),),
//                   ]
//                 ],
//               ),
//             );
//           }
//         else if(data.apiStatus == ApiStatus.empty)
//         {
//           return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr30)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr31)}',topMargin: 8,width: 40,);
//         }
//         else if(data.apiStatus == ApiStatus.error)
//         {
//           return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
//         }
//         else
//         {
//           return const CircularIndicatorCustomized();
//         }
//       }
//     );
//   }
//   void rejectPressed()
//   {
//     Provider.of<ApprovalsDetailCollector>(context,listen: false).updateType(AcceptReject.reject);
//     CallBottomSheetForRemarks().call(context, Provider.of<ApprovalsDetailCollector>(context,listen: false), Provider.of<ApprovalsAcceptRejectCollector>(context,listen: false));
//   }
//
//   void approvePressed()
//   {
//     Provider.of<ApprovalsDetailCollector>(context,listen: false).updateType(AcceptReject.accept);
//     CallBottomSheetForRemarks().call(context, Provider.of<ApprovalsDetailCollector>(context,listen: false), Provider.of<ApprovalsAcceptRejectCollector>(context,listen: false));
//   }
// }
//
// class ListBodyOfDetail extends StatelessWidget {
//   final LeaveDetail? leaveDetail;
//   const ListBodyOfDetail(this.leaveDetail, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
//         padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.8)),
//         decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(15)),
//             border: Border.all(
//               color: const Color(MyColor.colorBackgroundDark),
//               width: 1,
//             )
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: RichText(
//                     text: TextSpan(
//                       text: '${CallLanguageKeyWords.get(context, LanguageCodes.RequestedOn)} ',
//                         style: GetFont.get(
//                             context,
//                             fontSize: 2.0,
//                             fontWeight: FontWeight.w400,
//                             color: MyColor.colorBlack
//                         ),
//                       children: [
//                         TextSpan(
//                           text: GetDateFormats().getFilterDate(leaveDetail?.requestDate)??'',
//                           style: GetFont.get(
//                               context,
//                               fontSize: 2.2,
//                               fontWeight: FontWeight.w600,
//                               color: MyColor.colorBlack
//                           ),
//                         ),
//                       ]
//                     ),
//                   )
//                 ),
//                 SizedBox(width: ScreenSize(context).heightOnly( 1),),
//                 Text(
//                   leaveDetail?.typeTitle??'',
//                   style: GetFont.get(
//                       context,
//                       fontSize: 1.8,
//                       fontWeight: FontWeight.w400,
//                       color: MyColor.colorBlack
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: ScreenSize(context).heightOnly( 0.7),),
//             RichText(
//               text: TextSpan(
//                   text: leaveDetail?.remarks??'',
//                   style: GetFont.get(
//                       context,
//                       fontSize: 1.6,
//                       fontWeight: FontWeight.w400,
//                       color: MyColor.colorGrey3
//                   ),
//                   children: [
//                     TextSpan(
//                       text:' ${CallLanguageKeyWords.get(context, LanguageCodes.approvalKey)} ',
//                       style: GetFont.get(
//                           context,
//                           fontSize: 1.6,
//                           fontWeight: FontWeight.w600,
//                           color: MyColor.colorBlack
//                       ),
//                     ),
//                     TextSpan(
//                       text:leaveDetail?.employeeName??'',
//                       style: GetFont.get(
//                           context,
//                           fontSize: 1.6,
//                           fontWeight: FontWeight.w400,
//                           color: MyColor.colorGrey3
//                       ),
//                     ),
//                   ]
//               ),
//             ),
//             SizedBox(height: ScreenSize(context).heightOnly( 2),),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     '${CallLanguageKeyWords.get(context, LanguageCodes.RequestApplicationCode)}:    ',
//                     style: GetFont.get(
//                         context,
//                         fontSize: 1.6,
//                         fontWeight: FontWeight.w600,
//                         color: MyColor.colorBlack
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '${leaveDetail?.applicationCode}',
//                   style: GetFont.get(
//                       context,
//                       fontSize: 1.6,
//                       fontWeight: FontWeight.w600,
//                       color: MyColor.colorBlack
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: ScreenSize(context).heightOnly( 1),),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     '${CallLanguageKeyWords.get(context, LanguageCodes.LeaveFrom)}',
//                     style: GetFont.get(
//                         context,
//                         fontSize: 1.8,
//                         fontWeight: FontWeight.w600,
//                         color: MyColor.colorBlack
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '${GetDateFormats().getFilterDate(leaveDetail?.leaveFrom)} ',
//                   style: GetFont.get(
//                       context,
//                       fontSize: 1.8,
//                       fontWeight: FontWeight.w400,
//                       color: MyColor.colorBlack
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: ScreenSize(context).heightOnly( 1),),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     '${CallLanguageKeyWords.get(context, LanguageCodes.LeaveTo)}',
//                     style: GetFont.get(
//                         context,
//                         fontSize: 1.8,
//                         fontWeight: FontWeight.w600,
//                         color: MyColor.colorBlack
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '${GetDateFormats().getFilterDate(leaveDetail?.leaveTo)} ',
//                   style: GetFont.get(
//                       context,
//                       fontSize: 1.8,
//                       fontWeight: FontWeight.w400,
//                       color: MyColor.colorBlack
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: ScreenSize(context).heightOnly( 1),),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     '${CallLanguageKeyWords.get(context, LanguageCodes.TotalDays)}',
//                     style: GetFont.get(
//                         context,
//                         fontSize: 1.8,
//                         fontWeight: FontWeight.w600,
//                         color: MyColor.colorBlack
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '${leaveDetail?.totalLeaves}',
//                   style: GetFont.get(
//                       context,
//                       fontSize: 1.8,
//                       fontWeight: FontWeight.w400,
//                       color: MyColor.colorBlack
//                   ),
//                 )
//               ],
//             ),
//           ],
//         )
//     );
//   }
// }
//
