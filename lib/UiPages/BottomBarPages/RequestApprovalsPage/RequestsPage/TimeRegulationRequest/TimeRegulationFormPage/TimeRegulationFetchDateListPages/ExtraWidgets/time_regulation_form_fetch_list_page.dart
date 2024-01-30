import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeRegulationModels/time_regulation_monthly_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/src/divider.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/TimeRegulationListener/TimeRegulationFormListeners/TimeRegulationFetchDateListListeners/time_regulation_form_list_listener.dart';
import '../../../../../../../../src/colors.dart';
import '../../../../../../../../src/date_formats.dart';
import '../../../../../../../../src/fonts.dart';
import '../../../../../../../../src/screen_sizes.dart';
import '../../../../../../../Reuse_LogicalWidgets/skeleton_list_widget.dart';
import '../../../TimeRegulationListWidgets/time_regulation_list_widgets.dart';

class TimeRegulationFormFetchListWidget extends StatelessWidget {
  final int index;
  final TimeRegulationMonthlyDataList? dataList;
  final Function() onTap;
  const TimeRegulationFormFetchListWidget(this.index, this.dataList, {Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Provider.of<TimeRegulationFormFetchListListener>(context,listen: false).reachedEnd&&index==Provider.of<TimeRegulationFormFetchListListener>(context,listen: false).dataList!.length-1?
      SkeletonListWidget(index,height: 25,)
          :
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              color: const Color(MyColor.colorGrey7),
              width: 1,
            )
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Material(
            color: const Color(MyColor.colorTransparent),
            child: InkWell(
              splashColor: const Color(MyColor.colorGrey0),
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.8)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Expanded(
                          child: Text(
                            '${CallLanguageKeyWords.get(context, LanguageCodes.on)}, ${GetDateFormats().getFilterDate(dataList?.attendanceDate)??''}',
                            style: GetFont.get(
                                context,
                                fontSize: 2.0,
                                fontWeight: FontWeight.w600,
                                color: MyColor.colorBlack
                            ),
                          ),
                        ),
                        if(dataList?.canApplyforthisTransaction == true)...[
                          SizedBox(width: ScreenSize(context).heightOnly( 1),),
                          Icon(
                            Icons.mode_edit_outline,
                            size: ScreenSize(context).heightOnly( 1.8),
                            color: const Color(MyColor.colorBlack),
                          )
                        ]
                      ],
                    ),
                    const DividerVertical(0.7),
                    OldTimeLine(
                      header1: '${CallLanguageKeyWords.get(context, LanguageCodes.timeIn)}',
                      header2: '${CallLanguageKeyWords.get(context, LanguageCodes.timeOut)}',
                      answer1: GetDateFormats().getFilterTime1(dataList?.timeIn)??'',
                      answer2: GetDateFormats().getFilterTime1(dataList?.timeOut)??'',
                      colorByIndex: true,
                      color: getColor(GetDateFormats().getMonthDay(dataList?.timeIn)),
                      colorExtra: getColor(GetDateFormats().getMonthDay(dataList?.timeOut)),
                    ),
                    const DividerVertical(0.7),
                    Wrap(
                      children: dataList?.statusList?.map((e) =>
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(0.4),vertical: ScreenSize(context).heightOnly(0.6)),
                            child: Material(
                                color: const Color(MyColor.colorGreySecondary),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(1.4),vertical: ScreenSize(context).heightOnly(0.6)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(e,style: GetFont.get(context,
                                            fontSize: 1.4,
                                            fontWeight: FontWeight.w400,
                                            color: MyColor.colorBlack),
                                        ),
                                      ],
                                    )
                                )
                            ),
                          )
                      ).toList()??[Container(height: 0,)],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  getColor(DateTime? timeIn)
  {
    if(timeIn!=null)
      {
        if(timeIn.hour>1)
          {
            return MyColor.colorPrimary;
          }
        else if(timeIn.minute>1)
        {
          return MyColor.colorPrimary;
        }
        else
          {
            return MyColor.colorRed;
          }
      }
    else
      {
        return MyColor.colorPrimary;
      }
  }
}
