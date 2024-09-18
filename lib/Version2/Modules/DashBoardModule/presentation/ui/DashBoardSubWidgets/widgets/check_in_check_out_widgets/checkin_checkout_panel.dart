import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/attendance_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/attendance_logic_builder.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/attendance_types_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/Version1/viewModel/sliding_up_panel.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';

class CheckInCheckOutTypes extends StatefulWidget {
  const CheckInCheckOutTypes({Key? key}) : super(key: key);

  @override
  _CheckInCheckOutTypesState createState() => _CheckInCheckOutTypesState();
}

class _CheckInCheckOutTypesState extends State<CheckInCheckOutTypes> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<AttendanceTypesCollector>(context,listen: false).attendanceTypesSetUp(context);
    });
    // OpenStreams.qrCodeStream.stream.listen((event) async {
    //   await Provider.of<SlidingPanelData>(context,listen: false).panelController?.close();
    //   startCheckingInOut();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceTypesCollector>(
        builder: (context, data, child) {
          return Stack(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 6.6),ScreenSize(context).heightOnly( 8),ScreenSize(context).widthOnly( 6.6),ScreenSize(context).heightOnly( 15) ),
                  itemBuilder: (context,index){
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20),),
                        // gradient: LinearGradient(
                        //     begin: Alignment.topCenter,
                        //     end: Alignment.bottomCenter,
                        //     colors: [const Color(MyColor.colorPrimary).withOpacity(0.6),const Color(MyColor.colorSecondary).withOpacity(0.6)]
                        // ),
                        border: Border.all(color: const Color(MyColor.colorBlack),width: 0.7),
                        color: const Color(MyColor.colorPrimary).withOpacity(0.1),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20),),
                        child: Material(
                          color: const Color(MyColor.colorWhite),
                          child: InkWell(
                            splashColor: const Color(MyColor.colorGreyPrimary),
                            onTap: (){
                              Provider.of<AttendanceTypesCollector>(context,listen: false).setAttendanceType(index);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 2)),
                              child: Row(
                                children: [
                                  Container(
                                      height: ScreenSize(context).heightOnly( 4.2),
                                      width: ScreenSize(context).heightOnly( 4.2),
                                      padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.9)),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10),),
                                        color: Color(data.list[index].color??MyColor.colorPrimary),
                                      ),
                                      child: SvgPicture.string(data.list[index].icon,color: const Color(MyColor.colorBlack),width: ScreenSize(context).heightOnly( 1.4),height: ScreenSize(context).heightOnly( 1.4),)
                                  ),
                                  SizedBox(width: ScreenSize(context).heightOnly( 2),),
                                  Expanded(
                                    child: Text(
                                      data.list[index].header,
                                      style: GetFont.get(
                                          context,
                                          fontSize:1.6,
                                          fontWeight: FontWeight.w400,
                                          color: MyColor.colorBlack
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: ScreenSize(context).heightOnly( 4.0),
                                      width: ScreenSize(context).heightOnly( 4.0),
                                      child: Icon(
                                        data.list[index].selected?
                                        MdiIcons.circle:
                                        MdiIcons.circleOutline
                                        ,color: Color(data.list[index].selected==true?MyColor.colorT6:MyColor.colorBlack),size: ScreenSize(context).heightOnly( 2.6),)
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(
                      height: ScreenSize(context).heightOnly( 1.5),
                    );
                  },
                  itemCount: data.list.length
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    bottom: true,
                    top: true,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: window.viewPadding.bottom>0?ScreenSize(context).heightOnly( 1.5):ScreenSize(context).heightOnly( 3.5)),
                      child: ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsaddFormButton)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 7.0,width: ScreenSize(context).widthOnly( 88),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: onConfirmed,),
                    ),
                  )),

            ],
          );
        }
    );
  }
  void onConfirmed()
  {
    Provider.of<AttendanceLogicBuilder>(context,listen: false).onConfirmedClicked(context);
  }

}
