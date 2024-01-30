import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/SummaryListeners/get_summary_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/SummaryListeners/leave_calender_model_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/ui_time_off_clicks.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

class SummaryWidget extends StatefulWidget {
  final TimeOffPageEnum timeOffPageEnum;
  const SummaryWidget(this.timeOffPageEnum, {Key? key}) : super(key: key);

  @override
  _SummaryWidgetState createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveSummaryModelListener>(
      builder: (context,data,child) {
        if(data.apiStatus == ApiStatus.done) {
          return ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 4.6),ScreenSize(context).heightOnly( 2),ScreenSize(context).widthOnly( 4.6),ScreenSize(context).heightOnly( 10)),
            itemBuilder: (context,index){
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20),),
                child: Material(
                  color: const Color(MyColor.colorGrey6),
                  child: InkWell(
                    splashColor: const Color(MyColor.colorGreyPrimary),
                    // onTap: (){
                    //   //Provider.of<AttendanceTypesCollector>(context,listen: false).setAttendanceType(index);
                    // },
                    child: Padding(
                      padding: EdgeInsets.all(ScreenSize(context).heightOnly( 2)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${data.leaveSummaryResultSet?[index].typeTitle}',
                              style: GetFont.get(
                                  context,
                                  fontSize:1.6,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.colorBlack
                              ),
                            ),
                          ),
                          Text(
                            '${data.leaveSummaryResultSet?[index].balance}',
                            style: GetFont.get(
                                context,
                                fontSize:2.2,
                                fontWeight: FontWeight.w600,
                                color: MyColor.colorBlack
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context,index){
              return SizedBox(
                height: ScreenSize(context).heightOnly( 2),
              );
            },
            itemCount: data.leaveSummaryResultSet?.length??0);
        }
        else if(data.apiStatus == ApiStatus.empty)
        {
          return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr19)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr20)}',topMargin: 8,width: 40,);
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
