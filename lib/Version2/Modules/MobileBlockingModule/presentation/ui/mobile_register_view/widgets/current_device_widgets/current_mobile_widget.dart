import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../utils/Reuse_LogicalWidgets/tick_icon.dart';
import '../../../../../../../../configs/language_codes.dart';
import '../../../../../domain/models/device_add_remove_mapper.dart';
import '../../../../../utils/name_box.dart';

class CurrentMobileWidget extends StatelessWidget {
  final MobileInfoModel? data;
  const CurrentMobileWidget({this.data,super.key});

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(25));
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6),vertical: ScreenSize(context).heightOnly(2)),
      width: double.infinity,
      padding: EdgeInsets.all(ScreenSize(context).heightOnly(2)),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      CallLanguageKeyWords.get(context, LanguageCodes.currentDevice)??'',
                      style: GetFont.get(
                          context,
                          fontSize: 2.0,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorPrimary
                      ),
                    ),
                  ),
                  const TickIcon(check: true,),

                ],
              ),
              const DividerByHeight(2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameBox(text: data?.name?.substring(0,1)??'',boxColor: MyColor.colorA1,),
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
                        const DividerByHeight(0.8,),
                        InfoRow(header: 'Device',value: (data?.deviceType??'').toUpperCase(),),
                        const DividerByHeight(0.4,),
                        InfoRow(header: 'Brand',value: (data?.brand??'').toUpperCase(),),
                        const DividerByHeight(0.4,),
                        InfoRow(header: '${data?.deviceType} Version',value: (data?.version??'').toUpperCase(),),
                        const DividerByHeight(0.4,),
                        InfoRow(header: 'Base Version',value: (data?.sysName??'').toUpperCase(),),
                        const DividerByHeight(0.4,),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class InfoRow extends StatelessWidget {
  final String header;
  final String? value;
  const InfoRow({required this.header,this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            header,
            style: GetFont.get(
                context,
                fontSize: 1.6,
                fontWeight: FontWeight.w400,
                color: MyColor.colorGrey3
            ),
          ),
        ),
        Flexible(
          child: Text(
            value??'',
            style: GetFont.get(
                context,
                fontSize: 1.6,
                fontWeight: FontWeight.w400,
                color: MyColor.colorBlack
            ),
          ),
        ),
      ],
    );
  }
}
