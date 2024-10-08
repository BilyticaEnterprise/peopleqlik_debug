import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeFormModule/presentation/ui/UiWidgets/ErrorWidgets/overtime_error_bottom_sheet.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeFormModule/presentation/ui/UiWidgets/FiltreUi/overtime_filter_ui.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeFormModule/presentation/ui/UiWidgets/SelectHoursUi/hour_bottom_sheet_ui.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';

import 'package:peopleqlik_debug/utils/BottomSheetUi/bottom_sheet_ui.dart';
import '../../../../../../../../../utils/loader_utils/loader_class.dart';
import '../../../../../../../ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../../../../../ApiModule/domain/model/show_error.dart';
import '../../../../../../../ApiModule/domain/model/api_global_model.dart';
import '../../../../../../../../../Version1/models/AuthModels/login_model.dart';
import '../../../../../../../../../Version1/models/TimeOffAndEnCashModel/overtime_api_mapper.dart';
import '../../../../../../../../../Version1/models/TimeOffAndEnCashModel/overtime_filter_mapper.dart';
import '../../../../../../../../../Version1/models/TimeOffAndEnCashModel/overtime_hour_mapper.dart';
import '../../../../../../../../../Version1/models/TimeOffAndEnCashModel/overtime_submit_mapper.dart';
import '../../../../../../../../../Version1/models/TimeOffAndEnCashModel/overtime_time_range_model.dart';
import '../../../../../../../../../Version1/models/call_setting_data.dart';

class OverTimeFormListener extends GetChangeNotifier with GetLoader
{
  OvertimeFilterMapper? overtimeFilterMapper;
  List<OvertimeHourWithEmployeeMapper>? overtimeHourFilterMapper;
  ApiStatus apiStatus = ApiStatus.nothing;

  void applyFilter(BuildContext context, dynamic filterValues)async {
    overtimeFilterMapper = OvertimeFilterMapper.fromJson(filterValues);
    if(overtimeFilterMapper!=null&&overtimeFilterMapper?.employeeList!=null&&overtimeFilterMapper!.employeeList!.isNotEmpty)
      {
        /// As soon as you get user select employees and days first create a list of date between startDate and EndDate
        /// then give that date list to every employee user has selected

        callTimeRangeApi(context);
      }
    else
      {
        apiStatus = ApiStatus.nothing;
      }
    notifyListeners();
  }

  void callFilter(BuildContext context) {
    ShowBottomSheet.show(
        context,
        height: 100,
        builder: FilterOverTime(previousSelectedOvertimeFilterMapper: overtimeFilterMapper,),
        callBack: (filterValues){
          if(filterValues!=null)
          {
            applyFilter(context,filterValues);
          }
        }
    );
  }

  void callHourBottomSheet(BuildContext context,int index) {
    /// So when user taps a employee we will take user to the hour bottom sheet page where he will put times according to each date
    ShowBottomSheet.show(
        context,
        height: 100,
        builder: OverTimeHourSheet(overtimeHourMapper: overtimeHourFilterMapper?[index].employeeDateTimeList,apiResultSet: overtimeHourFilterMapper?[index].apiResultSet,),
        callBack: (filterValues){
          if(filterValues!=null)
          {
            overtimeHourFilterMapper?[index].employeeDateTimeList = convertToList(filterValues);
            notifyListeners();
          }
        }
    );
  }
  getLengthOfSelectedDates(List<EmployeeDateTimeList>? list)
  {
    return list?.where((element) => element.selectedDateTime!=null).toList().length;
  }

  convertToList(dynamic list)
  {
    if (list != null) {
      var employeeTimeList = <EmployeeDateTimeList>[];
      list.forEach((v) {
        employeeTimeList.add(EmployeeDateTimeList.fromJson(v));
      });
      return employeeTimeList;
    }
    return null;
  }

  /// After applying filter call information according to user selected dates
  callTimeRangeApi(BuildContext context) async
  {
    apiStatus = ApiStatus.started;
    notifyListeners();

    OvertimeApiMapper overtimeApiMapper = OvertimeApiMapper(
        employeeCodes: List.generate(overtimeFilterMapper?.employeeList?.length??0, (index) => overtimeFilterMapper?.employeeList?[index].employeeCode),
        fromDate: GetDateFormats().getMonthFormatDay(overtimeFilterMapper?.startDate),
        toDate: GetDateFormats().getMonthFormatDay(overtimeFilterMapper?.endDate),
        overtimeType: overtimeFilterMapper?.typeId
    );

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getOvertimeTimeRange(context,overtimeApiMapper.toJson());

    if(apiResponse.apiStatus==ApiStatus.done)
    {
      apiStatus = ApiStatus.done;
      overtimeHourFilterMapper = getEmployeeAndTimeList(apiResponse.data?.resultSet,overtimeFilterMapper);
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      apiStatus = ApiStatus.empty;
      ShowErrorMessage.show(apiResponse);
      overtimeHourFilterMapper = null;
      notifyListeners();
    }
    else
    {
      apiStatus = ApiStatus.error;
      overtimeHourFilterMapper = null;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }


  getEmployeeAndTimeList(List<OvertimeTimeRangeResultSet>? _apiResultSet, OvertimeFilterMapper? _overtimeFilterMapper)
  {
    List<List<OvertimeTimeRangeResultSet>?>? list = List.generate(_overtimeFilterMapper?.employeeList?.length??0, (index) => _apiResultSet?.where((element) => element.employeeCode == _overtimeFilterMapper?.employeeList?[index].employeeCode).toList());

    return List.generate(list.length, (index) => OvertimeHourWithEmployeeMapper(
        teamDataList: _overtimeFilterMapper?.employeeList?[index],
        employeeDateTimeList: List.generate(list[index]?.length??0, (x) =>
            EmployeeDateTimeList(
                date: GetDateFormats().getMonthDay(list[index]?[x].tDate),
                selectedDateTime: null
            )
        ),
        apiResultSet: list[index]
    ));
  }

  Future<ApplyOvertimeMapper?> prepareMapperToSubmit(BuildContext context,SettingsModelListener settingsModelListener)
  async {
    LoginResultSet loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    List<OvertimeList>? applyOverTimeList = List.empty(growable: true);
    if(overtimeHourFilterMapper!=null)
      {
        for(var element in overtimeHourFilterMapper!)
        {
          bool check = false;
          for(int x=0;x<element.apiResultSet!.length;x++)
          {
            if(Duration(hours: element.employeeDateTimeList?[x].selectedDateTime?.hour??0,minutes: element.employeeDateTimeList?[x].selectedDateTime?.minute??0).inMinutes>0)
            {
              check = true;
            }
            applyOverTimeList.add(
                OvertimeList(
                  entryID: 0,
                  employeeCode: element.teamDataList?.employeeCode,
                  companyCode: element.teamDataList?.companyCode,
                  cultureID: loginResultSet.headerInfo?.cultureID,
                  calendarCode: settingsModelListener.settingsResultSet?.selectedCompanyLeaveCalendar?.first.calendarCode,
                  actualOVTHours: element.employeeDateTimeList?[x].selectedDateTime!=null?Duration(hours:element.employeeDateTimeList?[x].selectedDateTime?.hour??0,minutes: element.employeeDateTimeList?[x].selectedDateTime?.minute??0).inMinutes:0,
                  approvedOVTHours: element.employeeDateTimeList?[x].selectedDateTime!=null?Duration(hours:element.employeeDateTimeList?[x].selectedDateTime?.hour??0,minutes: element.employeeDateTimeList?[x].selectedDateTime?.minute??0).inMinutes:0,
                  active: 0,
                  fromDate: GetDateFormats().getMonthFormatDay(element.employeeDateTimeList?[x].date),
                  toDate: GetDateFormats().getMonthFormatDay(element.employeeDateTimeList?[x].date),
                  approvalStatusID: 1,
                  typeID: overtimeFilterMapper?.typeId,
                )
            );
          }
          if(check==false)
          {
            return null;
          }
        }
        return ApplyOvertimeMapper(
          overtimeList: applyOverTimeList,
          fromDate: GetDateFormats().getMonthFormatDay(overtimeFilterMapper?.startDate),
          toDate: GetDateFormats().getMonthFormatDay(overtimeFilterMapper?.endDate),
        );
      }
    else
      {
        return null;
      }
  }
  submit(BuildContext context)async
  {

    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    ApplyOvertimeMapper? mapper = await prepareMapperToSubmit(context,settingsModelListener);
    if(mapper!=null)
      {

        if(settingsModelListener.settingsResultSet?.selectedCompanyLeaveCalendar!=null&&settingsModelListener.settingsResultSet!.selectedCompanyLeaveCalendar!.isNotEmpty)
        {
          initLoader();
          ApiResponse apiResponse = await UseCaseGetApisUrlCaller().applyOvertimeTime(context,mapper.toJson());
          await Future.delayed(const Duration(milliseconds: 100));
          await closeLoader();
          if(apiResponse.apiStatus == ApiStatus.done)
            {
              SnackBarDesign.happySnack('${CallLanguageKeyWords.get(context, LanguageCodes.UploadedSuccessfully)}');
              Navigator.pop(context,true);
            }
          else
            {
              if(apiResponse.data!=null&&apiResponse.data.errorResultSet!=null)
                {
                  Future.delayed(const Duration(milliseconds: 100),(){
                    ShowBottomSheet.show(
                        context,
                        height: 90,
                        body: OvertimeErrorBottomSheet(apiResponse),
                        callBack: (filterValues){

                        }
                    );
                  });
                }
              else
                {
                  ShowErrorMessage.show(apiResponse);
                }
            }
        }
        else
        {
          SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.calenderError1));
        }
      }
    else
      {
        SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.overTimeMustSelect));
      }
  }
}