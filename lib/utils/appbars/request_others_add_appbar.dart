// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
// import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
// import 'package:peopleqlik_debug/utils/Enums/request_enums.dart';
// import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_collector.dart';
// 
// import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
// import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestPanelController/request_panel_controller.dart';
// import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/RequestLeaveEncashmentListeners/request_encashment_list_listener.dart';
// import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_list_listener.dart';
// import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/request_list_listener.dart';
// import 'package:peopleqlik_debug/Version1/viewModel/settings_listeners.dart';
// import 'package:peopleqlik_debug/Version1/Mixins/go_back.dart';
// import 'package:peopleqlik_debug/src/colors.dart';
// import 'package:peopleqlik_debug/src/fonts.dart';
// import 'package:peopleqlik_debug/src/icons.dart';
// import 'package:peopleqlik_debug/src/pages_name.dart';
// import 'package:peopleqlik_debug/src/screen_sizes.dart';
// import 'package:provider/provider.dart';
// import 'package:sliding_up_panel/src/panel.dart';
//
// class RequestAllFixedAddAppBarWidget extends StatelessWidget with GoBack{
//   String title;
//   RequestsEnum? requestsEnum;
//   PanelController panelController;
//   RequestDataTaker? requestDataTaker;
//   RequestAllFixedAddAppBarWidget(this.title,this.requestsEnum, this.panelController, this.requestDataTaker, {Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
//     return Container(
//       padding:EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 4.6)),
//       height: ScreenSize(context).heightOnly( 6.5),
//       child: Stack(
//         children: [
//           Align(
//             alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.centerRight:Alignment.centerLeft,
//             child: ClipRRect(
//               borderRadius:const BorderRadius.all(Radius.circular(5)),
//               child: Material(
//                 color: const Color(MyColor.colorTransparent),
//                 child: InkWell(
//                   splashColor: const Color(MyColor.colorGrey0),
//                   onTap:(){
//                     //Provider.of<EmployeeSearchController>(context,listen: false).clearEmployeeData();
//                     Navigator.pop(context);
//                   },
//                   child:  Padding(
//                     padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.5)),
//                     child: SvgPicture.string(changeLanguage.languageEnum == LanguageEnum.arabic?SvgPicturesData.backRight:SvgPicturesData.back,width: ScreenSize(context).heightOnly( 3.0),height:ScreenSize(context).heightOnly( 3.0),color: const Color(MyColor.colorBlack),),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Align(
//               alignment: Alignment.center,
//               child: Text(
//                 title,
//                 style: GetFont.get(
//                     context,
//                     fontSize: 2.0,
//                     color: MyColor.colorBlack,
//                     fontWeight: FontWeight.w600
//                 ),
//               )
//           ),
//           Align(
//               alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.centerLeft:Alignment.centerRight,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 0)),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       height: ScreenSize(context).heightOnly( 6.4),
//                       child: Consumer<EmployeeSearchController>(
//                           builder: (context,employeeData,child,) {
//                             return Stack(
//                               children: [
//                                 employeeData.selectedIndex!=-1?
//                                 CachedNetworkImage(
//                                     imageUrl: '${RequestType.profileUrl}${employeeData.teamDataList?[employeeData.selectedIndex].picture}',
//                                     imageBuilder: (context, imageProvider) => Container(
//                                       width:ScreenSize(context).heightOnly(4.5),
//                                       height: ScreenSize(context).heightOnly(4.5),
//                                       margin: EdgeInsets.only(left: ScreenSize(context).heightOnly( 1.4),top: ScreenSize(context).heightOnly( 1.0)),
//                                       padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.rectangle,
//                                         borderRadius: const BorderRadius.all(Radius.circular(10)),
//                                         color: const Color(MyColor.colorWhite),
//                                         border: Border.all(
//                                             color: const Color(MyColor.colorPrimary),
//                                             width: 1.5
//                                         ),
//                                         image: DecorationImage(
//                                           image: imageProvider,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     placeholder: (context, url) => Container(
//                                       width:ScreenSize(context).heightOnly(4.5),
//                                       height: ScreenSize(context).heightOnly(4.5),
//                                       margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1)),
//                                       padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
//                                       decoration: BoxDecoration(
//                                           shape: BoxShape.rectangle,
//                                           borderRadius: const BorderRadius.all(Radius.circular(10)),
//                                           color: const Color(MyColor.colorWhite),
//                                           border: Border.all(
//                                               color: const Color(MyColor.colorPrimary),
//                                               width: 1.5
//                                           )
//
//                                       ),
//                                       child: const ClipOval(
//                                           child: Center(child: CircularProgressIndicator())
//                                       ),
//                                     ),
//                                     errorWidget: (context, url, error) => Container(
//                                         width:ScreenSize(context).heightOnly(4.5),
//                                         height: ScreenSize(context).heightOnly(4.5),
//                                         margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1)),
//                                         padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.rectangle,
//                                             borderRadius: const BorderRadius.all(Radius.circular(10)),
//                                             color: const Color(MyColor.colorWhite),
//                                             border: Border.all(
//                                                 color: const Color(MyColor.colorPrimary),
//                                                 width: 1.5
//                                             )
//
//                                         ),
//                                         child: ClipRRect(
//                                           borderRadius: const BorderRadius.all(Radius.circular(10)),
//                                           child: Image.asset('assets/avatar.png',fit: BoxFit.cover,
//                                           ),
//                                         )
//                                     )
//                                 )
//                                     :
//                                 Container(
//                                   margin: EdgeInsets.only(left: ScreenSize(context).heightOnly( 1.4),top: ScreenSize(context).heightOnly( 1.0)),
//                                   child: ClipRRect(
//                                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                                     child: Material(
//                                       color: const Color(MyColor.colorPrimary),
//                                       child: InkWell(
//                                         splashColor: const Color(MyColor.colorGrey0),
//                                         onTap: () async {
//                                           await panelController.open();
//                                         },
//                                         child: CachedNetworkImage(
//                                             imageUrl: '${RequestType.profileUrl}${Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.headerInfo?.picture??""}',
//                                             imageBuilder: (context, imageProvider) => Container(
//                                               width: ScreenSize(context).heightOnly(4.5),
//                                               height: ScreenSize(context).heightOnly(4.5),
//                                               padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
//                                               decoration: BoxDecoration(
//                                                 shape: BoxShape.rectangle,
//                                                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                                                 color: const Color(MyColor.colorWhite),
//                                                 border: Border.all(
//                                                     color: const Color(MyColor.colorPrimary),
//                                                     width: 1.5
//                                                 ),
//                                                 image: DecorationImage(
//                                                   image: imageProvider,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                             ),
//                                             placeholder: (context, url) => Container(
//                                               width:ScreenSize(context).heightOnly(4.5),
//                                               height: ScreenSize(context).heightOnly(4.5),
//                                               padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
//                                               decoration: BoxDecoration(
//                                                   shape: BoxShape.rectangle,
//                                                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                                                   color: const Color(MyColor.colorWhite),
//                                                   border: Border.all(
//                                                       color: const Color(MyColor.colorPrimary),
//                                                       width: 1.5
//                                                   )
//
//                                               ),
//                                               child: const ClipOval(
//                                                   child: Center(child: CircularProgressIndicator())
//                                               ),
//                                             ),
//                                             errorWidget: (context, url, error) => Container(
//                                                 width:ScreenSize(context).heightOnly(4.5),
//                                                 height: ScreenSize(context).heightOnly(4.5),
//                                                 padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
//                                                 decoration: BoxDecoration(
//                                                     shape: BoxShape.rectangle,
//                                                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                                                     color: const Color(MyColor.colorWhite),
//                                                     border: Border.all(
//                                                         color: const Color(MyColor.colorPrimary),
//                                                         width: 1.5
//                                                     )
//
//                                                 ),
//                                                 child: ClipRRect(
//                                                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                                                   child: Image.asset('assets/avatar.png',fit: BoxFit.cover,
//                                                   ),
//                                                 )
//                                             )
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 if(employeeData.selectedIndex!=-1)
//                                   ...[
//                                     ClipOval(
//                                       child: Material(
//                                         color: const Color(MyColor.colorBlack),
//                                         child: InkWell(
//                                           onTap: (){
//                                             Provider.of<EmployeeSearchController>(context,listen: false).clearEmployeeFilter(context);
//                                           },
//                                           child: Padding(
//                                             padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.8)),
//                                             child: SvgPicture.string(
//                                               SvgPicturesData.clear,
//                                               width: ScreenSize(context).heightOnly( 1.0),
//                                               height: ScreenSize(context).heightOnly( 1.0),
//                                               color: const Color(MyColor.colorWhite),
//                                             ),
//                                           ),
//
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 if(employeeData.selectedIndex==-1)
//                                   ...[
//                                     ClipOval(
//                                       child: Material(
//                                         color: const Color(MyColor.colorPrimary),
//                                         child: InkWell(
//                                           onTap: ()async{
//                                             await panelController.open();
//                                           },
//                                           child: Padding(
//                                             padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.8)),
//                                             child: SvgPicture.string(
//                                               SvgPicturesData.swap,
//                                               width: ScreenSize(context).heightOnly( 1.2),
//                                               height: ScreenSize(context).heightOnly( 1.2),
//                                               color: const Color(MyColor.colorWhite),
//                                             ),
//                                           ),
//
//                                         ),
//                                       ),
//                                     ),
//                                   ]
//                               ],
//                             );
//                           }
//                       ),
//                     ),
//                     SizedBox(width: ScreenSize(context).widthOnly( 2.5),),
//                     ClipRRect(
//                       borderRadius: const BorderRadius.all(Radius.circular(10)),
//                       child: Material(
//                         color: const Color(MyColor.colorPrimary),
//                         child: InkWell(
//                           splashColor: const Color(MyColor.colorGrey0),
//                           onTap: (){
//                             //Provider.of<EmployeeSearchController>(context,listen: false).clearEmployeeData();
//                             if(requestsEnum == RequestsEnum.encashment)
//                             {
//                               Navigator.pushNamed(context, CurrentPage.RequestSpecialFormPage,arguments: requestDataTaker).then((value){
//                                 Provider.of<EmployeeSearchController>(context,listen: false).justUpdatePage(EmployeeCalledForPage.encashment);
//                                 comeBack(context,value);
//                               });
//                             }
//                             else if(requestsEnum == RequestsEnum.speration)
//                             {
//                               Navigator.pushNamed(context, CurrentPage.RequestSeparationFormPage,arguments: requestDataTaker).then((value){
//                                 Provider.of<EmployeeSearchController>(context,listen: false).justUpdatePage(EmployeeCalledForPage.separation);
//                                 comeBack(context,value);
//                               });
//                             }
//                           },
//                           child: Padding(
//                               padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.8)),
//                               child: Icon(
//                                 MdiIcons.plus,
//                                 size: ScreenSize(context).heightOnly( 2.8),
//                                 color: const Color(MyColor.colorWhite),
//                               )
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               )
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   comeBack(BuildContext context, value) {
//     if(requestsEnum == RequestsEnum.encashment)
//     {
//         //Provider.of<EmployeeSearchController>(context,listen: false).clearEmployeeData(requestDataTaker: requestDataTaker);
//         Provider.of<GetEncashmentRequestListListener>(context,listen: false).start(context,ApiStatus.started);
//
//     }
//     else if(requestsEnum == RequestsEnum.speration)
//     {
//       //Provider.of<EmployeeSearchController>(context,listen: false).clearEmployeeData(requestDataTaker: requestDataTaker);
//       Provider.of<GetSeparationRequestListListener>(context,listen: false).start(context,ApiStatus.started);
//
//     }
//   }
// }