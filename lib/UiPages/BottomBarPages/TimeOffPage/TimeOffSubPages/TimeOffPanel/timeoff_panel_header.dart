// import 'package:flutter/material.dart';
// 
// import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/SummaryListeners/get_summary_collector.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/SummaryListeners/leave_calender_model_listener.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/time_off_panel_controller.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/ui_time_off_clicks.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/sliding_up_panel.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
// import 'package:peopleqlik_debug/src/colors.dart';
// import 'package:peopleqlik_debug/src/fonts.dart';
// import 'package:peopleqlik_debug/src/hide_keyboard.dart';
// import 'package:peopleqlik_debug/src/language_codes.dart';
// import 'package:peopleqlik_debug/src/prints_logs.dart';
// import 'package:peopleqlik_debug/src/screen_sizes.dart';
// import 'package:peopleqlik_debug/src/snackbar_design.dart';
// import 'package:provider/provider.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
//
// class TimeOffPanelHeader extends StatelessWidget {
//   TimeOffPanelHeader({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: ScreenSize(context).widthOnly(100),
//       height: ScreenSize(context).heightOnly(7),
//       padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 2.8),0,ScreenSize(context).widthOnly( 4.6),0),
//       decoration: const BoxDecoration(
//         color: Color(MyColor.colorWhite),
//         shape: BoxShape.rectangle,
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
//       ),
//       child: Consumer<TimeOffSlidingPanelController>(
//           builder: (context,data,child) {
//             PrintLogs.printLogs('headddddd ${data.currentPage}');
//             return Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: ClipOval(
//                     child: Material(
//                       color: const Color(MyColor.colorTransparent),
//                       child: InkWell(
//                           splashColor: const Color(MyColor.colorGrey0),
//                           onTap: () async{
//                            await Provider.of<TimeOffSlidingPanelController>(context,listen: false).panelController?.close();
//                            HideShowKeyboard.hide(context);
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.6)),
//                             child: Icon(
//                               Icons.cancel_outlined,
//                               size: ScreenSize(context).heightOnly( 3.2),
//                               color: const Color(MyColor.colorBlack
//                               ),
//                             ),
//                           )
//                       ),
//                     ),
//
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Center(
//                     child: Text(
//                       data.currentPage==SliderWidgetEnum.permission?"":data.currentPage==SliderWidgetEnum.checkInTypes?'${CallSettingsKeyWords.get(context, LanguageCodes.SelectMethod)}':data.currentPage==SliderWidgetEnum.employeeSearch?'Search Employee':'${CallSettingsKeyWords.get(context, LanguageCodes.SelectSummary)}',
//                       style: GetFont.get(
//                           context,
//                           fontSize:2.2,
//                           fontWeight: FontWeight.w600,
//                           color: MyColor.colorBlack
//                       ),
//                     ),
//                   ),
//                 ),
//                 if(data.currentPage != SliderWidgetEnum.permission&&data.currentPage != SliderWidgetEnum.checkInTypes)...[
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.all(Radius.circular(8)),
//                       child: Material(
//                         color: const Color(MyColor.colorPrimary),
//                         child: InkWell(
//                           splashColor: const Color(MyColor.colorGrey0),
//                           onTap: () async {
//                             try{HideShowKeyboard.hide(context);}catch(e){}
//                             if(data.currentPage==SliderWidgetEnum.summary)
//                             {
//                               await Provider.of<TimeOffSlidingPanelController>(context,listen: false).panelController?.close();
//                               LeaveCalenderModelListener leaveCalenderModelListener = Provider.of<LeaveCalenderModelListener>(context,listen: false);
//                               if(leaveCalenderModelListener.selectedIndex!=-1) {
//                                 Provider.of<LeaveSummaryModelListener>(context,listen: false).start(context, leaveCalenderModelListener.getIndexedCalender(leaveCalenderModelListener.selectedIndex)?.calendarCode);
//                               }
//                             }
//                             else
//                               {
//                                 if(Provider.of<EmployeeSearchController>(context,listen: false).selectedIndex!=-1)
//                                 {
//                                   await Provider.of<TimeOffSlidingPanelController>(context,listen: false).panelController?.close();
//                                   Provider.of<EmployeeSearchController>(context,listen: false).changeEmployeeCodeFor(context);
//
//                                 }
//                                 else
//                                 {
//                                   ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'${CallSettingsKeyWords.get(context, LanguageCodes.searchMustSelect)}',color: MyColor.colorRed));
//                                 }
//                               }
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1.4),vertical: ScreenSize(context).heightOnly( 0.6)),
//                             child: Text(
//                               '${CallSettingsKeyWords.get(context, LanguageCodes.done)}',
//                               style: GetFont.get(
//                                   context,
//                                   fontSize:1.3,
//                                   color: MyColor.colorWhite,
//                                   fontWeight: FontWeight.w600
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             );
//           }
//       ),
//     );
//   }
// }
