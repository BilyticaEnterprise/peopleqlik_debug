import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/Packages/CalendarWidget/Listeners/calendar_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/OverTimeListeners/overtime_team_list_listener.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../../../utils/MonthPicker/DatePicker/month_picker_dialog_2.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../configs/icons.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/lottie_anims_utils/lottie_string.dart';
import '../../../../../../../../../utils/Reuse_LogicalWidgets/skeleton_list_widget.dart';
import '../../../../../../../../utils/CommonUis/container_design_1.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import '../../../../../../../../utils/ScreenLoader/circular_indicator_customized.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../TimeRegulationRequest/TimeRegulationListWidgets/time_regulation_list_widgets.dart';
import 'UiWidgets/calendar_widget_app_bar.dart';
import 'UiWidgets/overtime_dashboard_list_widget.dart';

class OverTimeTeamRequestPage extends StatelessWidget {
  OverTimeTeamRequestPage({Key? key}) : super(key: key);

  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CalendarCollector>(create: (_) => CalendarCollector(DateTime.now())),
        ChangeNotifierProvider<OvertimeTeamListListener>(create: (_) => OvertimeTeamListListener())
      ],
      builder: (context, snapshot) {
        return GetPageStarterScaffoldStateLess(
          title: '${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardOverTimeHeader)}',
          addToolBarHeight: true,
          toolbarHeight: 9,
          action: ClipRRect(
            borderRadius:const BorderRadius.all(Radius.circular(5)),
            child: Material(
              color: const Color(MyColor.colorTransparent),
              child: InkWell(
                splashColor: const Color(MyColor.colorGrey0),
                onTap:(){
                  DateTime dateTime = DateTime.now();
                  showMonthPicker(
                    context: context,
                    firstDate: DateTime(dateTime.year - 1, 5),
                    lastDate: DateTime(dateTime.year + 1, 9),
                    initialDate: DateTime.now(),
                    locale: const Locale("en"),
                    selectedMonthTextColor: Color(MyColor.colorWhite),
                    selectedMonthBackgroundColor: Color(MyColor.colorPrimary),
                    headerTextColor: Color(MyColor.colorWhite),
                  ).then((date) {
                    if (date != null) {
                      CalendarCollector calendarCollector = Provider.of<CalendarCollector>(context,listen: false);
                      calendarCollector.currentDate = date;
                      calendarCollector.startCalender();
                      OvertimeTeamListListener overtimeTeamListListener = Provider.of<OvertimeTeamListListener>(context,listen: false);
                      overtimeTeamListListener.onDateReceived(date);
                      overtimeTeamListListener.start(context, ApiStatus.started);
                    }
                  });
                },
                child:  Padding(
                  padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.5)),
                  child: SvgPicture.string(SvgPicturesData.calendar,width: ScreenSize(context).heightOnly( 2.6),height:ScreenSize(context).heightOnly( 2.6),color: Color(MyColor.colorBlack),),
                ),
              ),
            ),
          ),
          bottomViewOffAppBar: PreferredSize(
            preferredSize: Size(ScreenSize(context).widthOnly(100),ScreenSize(context).heightOnly(16)),
            child: AppBarCalendarWidget(globalKey,onDateChange: (date){
              OvertimeTeamListListener overtimeTeamListListener = Provider.of<OvertimeTeamListListener>(context,listen: false);
              overtimeTeamListListener.onDateReceived(date);
              overtimeTeamListListener.start(context, ApiStatus.started);
            },),
          ),
          body: BodyData(),
        );
      }
    );
  }
}
class BodyData extends StatefulWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CalendarCollector>(context,listen: false).startCalender();
      Provider.of<OvertimeTeamListListener>(context,listen: false).start(context, ApiStatus.started);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<OvertimeTeamListListener>(
      builder: (context, data, child) {
        if(data.apiStatus == ApiStatus.done||data.apiStatus == ApiStatus.pagination)
          {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification){
                if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                {
                  data.updateStep(true, context);
                  return true;
                }
                else
                {
                  data.updateStep(false, context);
                  return false;
                }
              },
              child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 2), ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly(16)),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    if(data.reachedEnd&&index==data.dataList!.length-1)
                      {
                        return SkeletonListWidget(index,height: 22,);
                      }
                    else
                        {
                          return OverTimeListWidget(index,data.dataList?[index]);
                        }
                  },
                  separatorBuilder: (context,index){
                    return const DividerByHeight(3);
                  },
                  itemCount: data.dataList?.length??0
              ),
            );
          }
        else if(data.apiStatus == ApiStatus.empty)
        {
          return NotAvailable(LottieString.notAvailable, '${CallLanguageKeyWords.get(context, LanguageCodes.noInfoAvailableHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.noInfoAvailableValue)}',topMargin: 8,width: 40,);
        }
        else if(data.apiStatus == ApiStatus.error)
        {
          return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
        }
        else
        {
          return const CircularIndicatorCustomized();
        }
      }
    );
  }
}
