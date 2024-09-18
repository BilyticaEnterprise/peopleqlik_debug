import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/applied_for_employee.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/image_getter/cache_image.dart';
import 'package:peopleqlik_debug/utils/commonUis/container_design_1.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class AppliedForEmployeeWidget extends StatelessWidget {
  final AppliedForEmployee? data;
  const AppliedForEmployeeWidget({this.data,super.key});

  @override
  Widget build(BuildContext context) {
    if(data == null)
      {
        return Container(height: 0,);
      }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(5.6)),
      child: ContainerDesign1(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${CallLanguageKeyWords.get(context, LanguageCodes.appliedFor)}',
              style: GetFont.get(
                  context,
                  fontSize: 2.0,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
              ),
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 2),),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GetNetWorkImage(
                  image: '${RequestType.profileUrl}${data?.picture}',
                  size: 5.4,
                  boxShape: BoxShape.circle,
                  borderColor: MyColor.colorT5,
                  borderPadding: 0.2,
                ),
                const DividerByWidth(2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data?.oldEmployeeCode??'',
                        style: GetFont.get(
                            context,
                            fontSize: 1.4,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorGrey3
                        ),
                      ),
                      const DividerByHeight(0.3),
                      Text(
                        data?.fullName??'',
                        style: GetFont.get(
                            context,
                            fontSize: 1.6,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorBlack
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
