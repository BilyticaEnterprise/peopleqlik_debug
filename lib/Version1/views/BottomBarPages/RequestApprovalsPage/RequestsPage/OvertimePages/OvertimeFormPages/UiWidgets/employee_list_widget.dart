import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';

import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import '../../../../../../../../Version1/Models/TeamModel/get_team_model.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../utils/cached_image_getter/cache_image.dart';
import '../../../../../../../../../utils/date_formats.dart';
import '../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../configs/icons.dart';
import '../../../../../../../../../utils/screen_sizes.dart';
import '../../../../../../../../utils/CommonUis/container_design_1.dart';

class EmployeeListWidget extends StatelessWidget {
  final TeamDataList? teamDataList;
  final Function()? onTap;
  final int length;
  const EmployeeListWidget({this.teamDataList,this.length = 0,this.onTap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ContainerDesign1(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${teamDataList?.fullName}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.8,
                      fontWeight: FontWeight.w600,
                      color: MyColor.colorBlack
                  ),
                ),
                SizedBox(height: ScreenSize(context).heightOnly( 0.6),),
                Text(
                  '${teamDataList?.jobTitle}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.5,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorGrey3
                  ),
                ),
                SizedBox(height: ScreenSize(context).heightOnly( 1),),
                RichText(
                  text: TextSpan(
                      text: '${CallLanguageKeyWords.get(context, LanguageCodes.supervisor)}: ',
                      style: GetFont.get(
                        context,
                        fontSize: 1.4,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorBlack,
                      ),
                      children: [
                        TextSpan(
                          text: teamDataList?.supervisorName?.toUpperCase()??'',
                          style: GetFont.get(
                            context,
                            fontSize: 1.4,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorGrey3,
                          ),
                        )
                      ]
                  ),
                ),
                SizedBox(height: ScreenSize(context).heightOnly( 1),),
                RichText(
                  text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: SvgPicture.string(
                              SvgPicturesData.calendar1,
                              width: ScreenSize(context).heightOnly(2.0),
                              height: ScreenSize(context).heightOnly(2.0),
                              color: Color(length>0?MyColor.colorPrimary:MyColor.colorGrey3),
                            )
                        ),
                        WidgetSpan(child: SizedBox(width: ScreenSize(context).heightOnly( 1),)),
                        TextSpan(
                          text: '${CallLanguageKeyWords.get(context, LanguageCodes.overtimeSelected)} ',
                          style: GetFont.get(
                            context,
                            fontSize: 1.5,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorGrey3,
                          ),
                        ),
                        TextSpan(
                          text: '$length',
                          style: GetFont.get(
                            context,
                            fontSize: 1.5,
                            fontWeight: length>0?FontWeight.w700:FontWeight.w400,
                            color: length>0?MyColor.colorBlack:MyColor.colorGrey3,
                          ),
                        ),
                        TextSpan(
                          text: ' ${CallLanguageKeyWords.get(context, length>1?LanguageCodes.dates:LanguageCodes.date)}',
                          style: GetFont.get(
                            context,
                            fontSize: 1.5,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorGrey3,
                          ),
                        )
                      ]
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetNetWorkImage(image: teamDataList?.picture,baseUrl: RequestType.profileUrl,size: 6,boxShape: BoxShape.circle,),
              SizedBox(height: ScreenSize(context).heightOnly( 2),),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Material(
                  color: const Color(MyColor.colorGrey6),
                  child: InkWell(
                    splashColor: const Color(MyColor.colorGrey0),
                    //onTap: (){},
                    child: Padding(
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.75)),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: ScreenSize(context).heightOnly( 2.0),
                          color: const Color(MyColor.colorGrey3),
                        )
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
