import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../../ModuleSetting/domain/model/settings_model.dart';
import '../../../../../../../../utils/Reuse_LogicalWidgets/tick_icon.dart';
import '../../../../../domain/models/device_add_remove_mapper.dart';
import '../../../../../utils/name_box.dart';

class MobileListWidget extends StatelessWidget {
  final DeviceList? data;
  final Function(dynamic)? onTap;
  final bool? selected;
  const MobileListWidget({this.data,this.selected,required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(25));
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          width: 0.8,
          color: const Color(MyColor.colorBackgroundDark)
        )
      ),
      child: Material(
        borderRadius: borderRadius,
        color: const Color(MyColor.colorWhite),
        child: InkWell(
          borderRadius: borderRadius,
          splashColor: const Color(MyColor.colorGrey0),
          onTap: onTap!=null?(){
            onTap!(data!.iD);
          }:null,
          child: Padding(
            padding: EdgeInsets.all(ScreenSize(context).heightOnly(2)),
            child: Row(
              children: [
                NameBox(text: data?.name?.substring(0,1)??'',boxColor: MyColor.colorA4,),
                const DividerByWidth(4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data?.name??'',
                        style: GetFont.get(
                            context,
                            fontSize: 1.8,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorBlack
                        ),
                      ),
                      const DividerByHeight(0.4,),
                      Text(
                        data?.version??'${data?.deviceType}, ${data?.brand}, ${data?.sysName}, ${data?.systemVersion}',
                        style: GetFont.get(
                            context,
                            fontSize: 1.4,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorBlack
                        ),
                      ),
                      const DividerByHeight(0.4,),
                      RichText(
                        text: TextSpan(
                          text: '${CallLanguageKeyWords.get(context, LanguageCodes.status)}: ',
                          style: GetFont.get(
                              context,
                              fontSize: 1.4,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorBlack
                          ),
                          children: [
                            TextSpan(
                              text: '${data?.active == true?CallLanguageKeyWords.get(context, LanguageCodes.active):CallLanguageKeyWords.get(context, LanguageCodes.inActive)}',
                              style: GetFont.get(
                                  context,
                                  fontSize: 1.4,
                                  fontWeight: FontWeight.w600,
                                  color: data?.active == true?MyColor.colorPrimary:MyColor.colorRed
                              ),
                            )
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
                if(onTap!=null)...[
                  TickIcon(check: selected,),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
