import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/HolidaysListener/get_holiday_list_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/ui_time_off_clicks.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/get_holidays_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:provider/provider.dart';

import '../../../Reuse_Widgets/SkeletetonAnimation/skeleton_text.dart';

class HolidayPage extends StatelessWidget {
  final TimeOffPageEnum timeOffPageEnum;
  const HolidayPage(this.timeOffPageEnum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Consumer<HolidaysModelListener>(
        builder: (context, data, child) {
          if(data.apiStatus == ApiStatus.done|| data.apiStatus == ApiStatus.pagination){
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification){
                HolidaysModelListener holidaysModelListener = Provider.of<HolidaysModelListener>(context,listen: false);
                //PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                {
                  //PrintLogs.print('true');
                  holidaysModelListener.updateStep(true, context);
                  return true;
                }
                else
                {
                  holidaysModelListener.updateStep(false, context);
                  return false;
                }
              },
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 4.6),ScreenSize(context).heightOnly( 2),ScreenSize(context).widthOnly( 4.6),ScreenSize(context).heightOnly( 10)),
                  itemBuilder: (context,index){
                    return BodyWidget(data.dataList?[index],index);
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(
                      height: ScreenSize(context).heightOnly( 2),
                    );
                  },
                  itemCount: data.dataList?.length??0),
            );
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr47)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr48)}',topMargin: 8,width: 40,);
          }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr10)}',topMargin: 8,width: 40,);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
      );
  }
}
class BodyWidget extends StatelessWidget {
  final HolidayDataList? holidayDataList;
  final int? index;
  const BodyWidget(this.holidayDataList,this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<HolidaysModelListener>(context,listen: false).reachedEnd&&index==Provider.of<HolidaysModelListener>(context,listen: false).dataList!.length-1?
    Container(
      height: ScreenSize(context).heightOnly( 14),
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: const Color(MyColor.colorGrey7),
            width: 1,
          )
      ),
      child: SkeletonAnimation(
          key: Key('timeOffShimmer$index'),
          shimmerColor:Colors.white70,
          gradientColor:const Color(MyColor.colorGreyPrimary).withOpacity(0.2),
          curve:Curves.fastOutSlowIn, child: Container()),
    ):Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: const Color(MyColor.colorGrey7),
            width: 1,
          )
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        child: Material(
          color: const Color(MyColor.colorWhite),
          child: InkWell(
            splashColor: const Color(MyColor.colorGrey7),
            onTap: (){
              //Navigator.pushNamed(context, CurrentPage.TimeOffDetailPage,arguments: data);
            },
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${holidayDataList?.holidayType??''} ${holidayDataList?.holidayTitle??''}',
                          style: GetFont.get(
                              context,
                              fontSize: 1.6,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorGrey3
                          ),
                        ),
                      ),
                      // Text(
                      //   holidayDataList?.calendarTitle?.replaceAll('Holiday', '')??'',
                      //   style: GetFont.get(
                      //       context,
                      //       fontSize: 1.6,
                      //       fontWeight: FontWeight.w400,
                      //       color: MyColor.colorPrimary
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 0.3),),
                  Text(
                    '${GetDateFormats().getFilterDate(holidayDataList?.fromDate)} - ${GetDateFormats().getFilterDate(holidayDataList?.holidayDate)}',
                    style: GetFont.get(
                        context,
                        fontSize: 2.0,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorBlack
                    ),
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 1.0),),
                  Text(
                    holidayDataList?.calendarTitle??'',
                    style: GetFont.get(
                        context,
                        fontSize: 1.6,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorGrey3
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
