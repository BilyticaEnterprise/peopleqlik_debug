import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/Urls/urls.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/icons.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:provider/provider.dart';

import '../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../src/divider.dart';
import '../../Reuse_LogicalWidgets/add_click.dart';

class EmployeeAppBarWidget extends StatelessWidget{
  String title;
  Function() selectEmployeeTap,removeEmployeeTap;
  Function()? addFormClick;
  Function()? onBackTap;
  Function()? downArrowClick;
  EmployeeInfoMapper? employeeInfoMapper;
  bool? hidePlusButton;
  bool? hideEmployeeSearch;
  bool? showDownIcon;
  Widget? actionWidget;
  double? rightPadding,leftPadding;
  EmployeeAppBarWidget(this.title,{this.rightPadding,this.downArrowClick,this.hideEmployeeSearch,this.showDownIcon,this.onBackTap,this.hidePlusButton,this.actionWidget,this.employeeInfoMapper,required this.selectEmployeeTap,required this.removeEmployeeTap,this.addFormClick,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //PrintLogs.printLogs('asdasdas ${RequestType.profileUrl}${employeeInfoMapper?.picture??""}');
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
    return Container(
      padding:EdgeInsets.only(left: ScreenSize(context).widthOnly((changeLanguage.languageEnum == LanguageEnum.english?leftPadding:rightPadding)??4.6),right: ScreenSize(context).widthOnly((changeLanguage.languageEnum == LanguageEnum.english?rightPadding:leftPadding)??4.6)),
      height: ScreenSize(context).heightOnly( 6.5),
      child: Stack(
        children: [
          Align(
            alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.centerRight:Alignment.centerLeft,
            child: ClipRRect(
              borderRadius:const BorderRadius.all(Radius.circular(5)),
              child: Material(
                color: const Color(MyColor.colorTransparent),
                child: InkWell(
                  splashColor: const Color(MyColor.colorGrey0),
                  onTap:onBackTap??(){
                    Navigator.pop(context);
                  },
                  child:  Padding(
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.5)),
                    child: SvgPicture.string(changeLanguage.languageEnum == LanguageEnum.arabic?SvgPicturesData.backRight:SvgPicturesData.back,width: ScreenSize(context).heightOnly( 3.0),height:ScreenSize(context).heightOnly( 3.0),color: const Color(MyColor.colorBlack),),
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: GetFont.get(
                    context,
                    fontSize: 2.0,
                    color: MyColor.colorBlack,
                    fontWeight: FontWeight.w600
                ),
              )
          ),
          Align(
              alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.centerLeft:Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(hideEmployeeSearch != true)...[
                        SizedBox(
                          height: ScreenSize(context).heightOnly(6.4),
                          width:ScreenSize(context).heightOnly(6.0),
                          child: Stack(
                            children: [
                              employeeInfoMapper?.localEmployee==false?
                              Align(
                                alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.topRight:Alignment.topLeft,
                                child: CachedNetworkImage(
                                    imageUrl: '${RequestType.profileUrl}${employeeInfoMapper?.picture}',
                                    imageBuilder: (context, imageProvider) => Container(
                                      width:ScreenSize(context).heightOnly(4.5),
                                      height: ScreenSize(context).heightOnly(4.5),
                                      margin: EdgeInsets.only(left: changeLanguage.languageEnum == LanguageEnum.arabic?0:ScreenSize(context).heightOnly(0.6),right: changeLanguage.languageEnum == LanguageEnum.arabic?ScreenSize(context).heightOnly(0.4):0,top: ScreenSize(context).heightOnly( 1.0)),
                                      padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        color: const Color(MyColor.colorWhite),
                                        border: Border.all(
                                            color: const Color(MyColor.colorPrimary),
                                            width: 1.5
                                        ),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                      width:ScreenSize(context).heightOnly(4.5),
                                      height: ScreenSize(context).heightOnly(4.5),
                                      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1)),
                                      padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          color: const Color(MyColor.colorWhite),
                                          border: Border.all(
                                              color: const Color(MyColor.colorPrimary),
                                              width: 1.5
                                          )

                                      ),
                                      child: const ClipOval(
                                          child: Center(child: CircularProgressIndicator())
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                        width:ScreenSize(context).heightOnly(4.5),
                                        height: ScreenSize(context).heightOnly(4.5),
                                        margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1)),
                                        padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            color: const Color(MyColor.colorWhite),
                                            border: Border.all(
                                                color: const Color(MyColor.colorPrimary),
                                                width: 1.5
                                            )

                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                          child: Image.asset('assets/avatar.png',fit: BoxFit.cover,
                                          ),
                                        )
                                    )
                                ),
                              )
                                  :
                              Align(
                                alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.topRight:Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: changeLanguage.languageEnum == LanguageEnum.arabic?0:ScreenSize(context).heightOnly(0.6),right: changeLanguage.languageEnum == LanguageEnum.arabic?ScreenSize(context).heightOnly(0.4):0,top: ScreenSize(context).heightOnly( 1.0)),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    child: Material(
                                      color: const Color(MyColor.colorPrimary),
                                      child: InkWell(
                                        splashColor: const Color(MyColor.colorGrey0),
                                        onTap: selectEmployeeTap,
                                        child: CachedNetworkImage(
                                            imageUrl: '${RequestType.profileUrl}${employeeInfoMapper?.picture??""}',
                                            imageBuilder: (context, imageProvider) => Container(
                                              width: ScreenSize(context).heightOnly(4.5),
                                              height: ScreenSize(context).heightOnly(4.5),
                                              padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                color: const Color(MyColor.colorWhite),
                                                border: Border.all(
                                                    color: const Color(MyColor.colorPrimary),
                                                    width: 1.5
                                                ),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,

                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) => Container(
                                              width:ScreenSize(context).heightOnly(4.5),
                                              height: ScreenSize(context).heightOnly(4.5),
                                              padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                  color: const Color(MyColor.colorWhite),
                                                  border: Border.all(
                                                      color: const Color(MyColor.colorPrimary),
                                                      width: 1.5
                                                  )

                                              ),
                                              child: const ClipOval(
                                                  child: Center(child: CircularProgressIndicator())
                                              ),
                                            ),
                                            errorWidget: (context, url, error) => Container(
                                                width:ScreenSize(context).heightOnly(4.5),
                                                height: ScreenSize(context).heightOnly(4.5),
                                                padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                    color: const Color(MyColor.colorWhite),
                                                    border: Border.all(
                                                        color: const Color(MyColor.colorPrimary),
                                                        width: 1.5
                                                    )

                                                ),
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                  child: Image.asset('assets/avatar.png',fit: BoxFit.cover,
                                                  ),
                                                )
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if(employeeInfoMapper?.localEmployee==false)
                                ...[
                                  Align(
                                    alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.topLeft:Alignment.topRight,
                                    child: ClipOval(
                                      child: Material(
                                        color: const Color(MyColor.colorBlack),
                                        child: InkWell(
                                          onTap: removeEmployeeTap,
                                          child: Padding(
                                            padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.8)),
                                            child: SvgPicture.string(
                                              SvgPicturesData.clear,
                                              width: ScreenSize(context).heightOnly(1.0),
                                              height: ScreenSize(context).heightOnly(1.0),
                                              color: const Color(MyColor.colorWhite),
                                            ),
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              if(employeeInfoMapper?.localEmployee==true)
                                ...[
                                  Align(
                                    alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.topLeft:Alignment.topRight,
                                    child: ClipOval(
                                      child: Material(
                                        color: const Color(MyColor.colorPrimary),
                                        child: InkWell(
                                          onTap: selectEmployeeTap,
                                          child: Padding(
                                            padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.8)),
                                            child: SvgPicture.string(
                                              SvgPicturesData.swap,
                                              width: ScreenSize(context).heightOnly(1.2),
                                              height: ScreenSize(context).heightOnly(1.2),
                                              color: const Color(MyColor.colorWhite),
                                            ),
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                            ],
                          ),
                        ),
                      ],
                      if(hidePlusButton!=true)...[
                        SizedBox(width: ScreenSize(context).widthOnly(1.5),),
                        AddIconClick(onClick: addFormClick,)
                      ],
                      if(showDownIcon==true)...[
                        SizedBox(width: ScreenSize(context).widthOnly(1.5),),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          child: Material(
                            color: const Color(MyColor.colorPrimary),
                            child: InkWell(
                              splashColor: const Color(MyColor.colorGrey0),
                              onTap: downArrowClick,
                              child: Padding(
                                  padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.8)),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: ScreenSize(context).heightOnly( 2.8),
                                    color: const Color(MyColor.colorWhite),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                      if(actionWidget!=null)...[
                        const DividerHorizontal(1.6),
                        actionWidget!
                      ]
                    ],
                  )
              )
          )
        ],
      ),
    );
  }
}