import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Approvals/approvals_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/sliding_up_panel.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/TimeOffPage/SummarySubPages/panel_options_list_view.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Buttons/buttons.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/calender_time_widget.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/header_dropdown.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

class ApprovalsPanelBody extends StatelessWidget {
  final ScrollController? sc;
  ApprovalsPanelBody(this.sc, {Key? key}) : super(key: key);

  late BuildContext mContext;
  List<String> list = ['Select an option','Pending','Approved','Rejected'];
  List<String>? listScreens;
  List<int>? listScreensId;
  int? screenId = 0;
  List<ApprovalPageEnum> data = [ApprovalPageEnum.pending,ApprovalPageEnum.approve,ApprovalPageEnum.rejected];
  String? startDate,endDate;
  ApprovalPageEnum? approvalPageEnum;
  @override
  Widget build(BuildContext context) {
    mContext = context;
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    if(settingsModelListener.settingsResultSet?.approvalScreen!=null&&settingsModelListener.settingsResultSet!.approvalScreen!.isNotEmpty)
      {
        listScreens ??= List.empty(growable: true);
        listScreensId ??= List.empty(growable: true);
        listScreens?.clear();
        listScreensId?.clear();
        listScreensId?.add(-1);
        listScreensId?.add(0);
        listScreens?.add('${CallLanguageKeyWords.get(context, LanguageCodes.option)}');
        listScreens?.add('All');
        for(int x=0;x<settingsModelListener.settingsResultSet!.approvalScreen!.length;x++)
          {
            listScreensId?.add(settingsModelListener.settingsResultSet!.approvalScreen![x].screenID!);
            listScreens?.add(settingsModelListener.settingsResultSet!.approvalScreen![x].screenName!);
          }
        //PrintLogs.print('sceeeee ${listScreensId}');
      }
    return Consumer<ApprovalCollector>(
      builder: (context,approvalData,child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: ScreenSize(context).heightOnly( 10),),
            HeaderDropDownField(DropDownDataType(DropDownTypeEnum.leaveReason,list),'${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilter1)}',dropdownCallBack,false,clearAll: approvalData.clearFilter,key: Key('statusDropDown${approvalData.clearFilter}'),),
            SizedBox(height: ScreenSize(context).heightOnly( 2),),
            HeaderDropDownField(DropDownDataType(DropDownTypeEnum.leaveReason,listScreens!),'${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilter2)}',dropdownScreensCallBack,false,clearAll: approvalData.clearFilter,key: Key('statusScreensDropDown${approvalData.clearFilter}'),),
            SizedBox(height: ScreenSize(context).heightOnly( 2),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
              child: Row(
                children: [
                  Expanded(child: CalenderTimeWidget(CalenderTimeEnum.calenderStart,'${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterStartDate)}','${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterButton1)}',dateTimeCallBack,false,allowedPreviously: true,clearAll: approvalData.clearFilter,)),
                  SizedBox(width: ScreenSize(context).widthOnly( 3.5),),
                  Expanded(child: CalenderTimeWidget(CalenderTimeEnum.calenderEnd,'${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterEndDate)}','${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterButton1)}',dateTimeCallBack,false,allowedPreviously: true,clearAll: approvalData.clearFilter,))
                ],
              ),
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 6),),
            if(approvalData.approvalFiltersEnum!=ApprovalPageEnum.nothing)
              ...[
                ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterButton2)}',buttonColor: MyColor.colorBlack,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: clearFilterPressed,),
                SizedBox(height: ScreenSize(context).heightOnly( 2),),
              ],
            ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterButton3)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: confirmPressed,),

          ],
        );
      }
    );
  }
  void dropdownCallBack(SelectedDropDown text)
  {
    //PrintLogs.printLogs('tessssaa ${text.index!}');
    approvalPageEnum = data[text.index!];
  }
  void dropdownScreensCallBack(SelectedDropDown text)
  {
    //PrintLogs.printLogs('tessss ${text.index!}');
    screenId = listScreensId?[text.index!+1];
  }
  Future<void> clearFilterPressed()
  async {
    approvalPageEnum = ApprovalPageEnum.nothing;
    screenId = 0;
    Provider.of<ApprovalCollector>(mContext!,listen: false).clearFilters(mContext!);
    await Provider.of<ApprovalCollector>(mContext!,listen: false).panelController?.close();

  }
  Future<void> confirmPressed()
  async {
    if(approvalPageEnum!=null)
      {
        //PrintLogs.printLogs('appriasva $approvalPageEnum');
        await Provider.of<ApprovalCollector>(mContext!,listen: false).panelController?.close();
        Provider.of<ApprovalCollector>(mContext!,listen: false).updateFilters(mContext!, startDate, endDate, approvalPageEnum,screenId);
      }
    else
      {
        if(approvalPageEnum==null)
          {
            SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(mContext!, LanguageCodes.Stringsstr43)}');
            // ScaffoldMessenger.of(mContext!).showSnackBar(SnackBarDesign.getSessionSnackBar(mContext!,'${CallLanguageKeyWords.get(mContext!, LanguageCodes.Stringsstr43)}',color: MyColor.colorRed));
          }
        // else if(startDate==null||endDate==null)
        //   {
        //     ScaffoldMessenger.of(mContext!).showSnackBar(SnackBarDesign.getSessionSnackBar(mContext!,GetVariable.approvalDateIssue,color: MyColor.colorRed));
        //   }
      }
  }
  void dateTimeCallBack(SelectedDateTime timeDate)
  {
    String? date = GetDateFormats().getYMEDtoYYYYMMDD(timeDate.dateTime);
    if(timeDate.calenderTimeEnum == CalenderTimeEnum.calenderStart)
      {
        startDate = date;
      }
    else
      {
        endDate = date;
      }
  }
}

