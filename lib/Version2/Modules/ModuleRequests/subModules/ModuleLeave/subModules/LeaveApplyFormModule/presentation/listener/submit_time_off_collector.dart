import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/time_off_add_edit_attachments_collector.dart';
import 'package:peopleqlik_debug/Version1/models/TimeOffAndEnCashModel/apply_leave_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_create_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_get_form_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_leave_balance.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/calendars/calender_time_widget.dart';
import 'package:peopleqlik_debug/utils/dropDowns/LegacyDropdown/header_dropdown.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../../../../../../../../utils/loader_utils/loader_class.dart';
import '../../../../../../../ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import 'get_time_off_leave_balance_collector.dart';

class AddTimeOffCollector extends GetChangeNotifier with GetLoader
{
  LeaveCreateFormResultSet? leaveCreateFormResultSet;
  ApplyLeaveForm? applyLeaveForm;
  List<GetFileType>? fileTypes;
  int? index;
  LeaveApplyJson? leaveApplyJson;
  TextEditingController emergencyNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  int datesKey = 100;

  AddTimeOffCollector()
  {
    applyLeaveForm = ApplyLeaveForm();
  }
  void saveDataForLogics(LeaveCreateFormResultSet? leaveCreateFormResultSet,int? index)
  {
    this.leaveCreateFormResultSet = leaveCreateFormResultSet;
    /// saving leaveTypeCode
    applyLeaveForm?.leaveTypeCode = leaveCreateFormResultSet!.leaveType![index!].typeCode;
    this.index = index;
  }
  void checkFullHalfDayType(BuildContext? context,SelectedDropDown? selectedDropDown) {
    /// We are checking either user select full day or half day because halfLeaveTypeID will be Zero if user select
    /// FullDay (so FullDay means = 0, 1st Half = 1, 2nd Half = 2 in ISFULLDAY Dropdown)
    /// so if user select half day which means user can only select current day date or he can select his
    /// desire date but if user select full day which means he can select any date range
    /// If user Select FullDay then fullDayLeave = 1 and halfLeaveTypeID = 0

    //PrintLogs.printLogs('check calledddddd');
    if(selectedDropDown?.selectedValue == '${CallLanguageKeyWords.get(context!, LanguageCodes.fullDay)}')
    {
      applyLeaveForm?.fullDayLeave = 1;
      applyLeaveForm?.halfLeaveTypeID = 0;
      Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false).updateEitherFullDay(1);
      resetDates();
    }
    else if(selectedDropDown?.selectedValue == '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffHourly)}')
    {
      //PrintLogs.printLogs('Andrrrrsdfsdfdad');
      applyLeaveForm?.fullDayLeave = 0;
      applyLeaveForm?.halfLeaveTypeID = 0;
      resetDates();
      Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false).updateEitherFullDay(2);
    }
    else
    {
      //PrintLogs.printLogs('jhasbdhgasgfdfast ${leaveCreateFormResultSet?.halfLeaveDropdown![selectedDropDown!.index! - 1].iD}');
      applyLeaveForm?.fullDayLeave = 0;
      applyLeaveForm?.halfLeaveTypeID = leaveCreateFormResultSet?.halfLeaveDropdown![selectedDropDown!.index! - 1].iD;
     // PrintLogs.printLogs('sdas ${leaveCreateFormResultSet?.halfLeaveDropdown![selectedDropDown!.index! - 1].iD}');
      resetDates();
      Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false).updateEitherFullDay(3);
    }
  }
  resetDates()
  {
    datesKey = Random().nextInt(2000);
    applyLeaveForm?.timeStart = null;
    applyLeaveForm?.timeEnd = null;
    applyLeaveForm?.dateStart = null;
    applyLeaveForm?.dateEnd = null;
    applyLeaveForm?.dateSelect = null;

  }
  void checkLeaveReasonType(BuildContext context, int? index, List<LeaveReasons>? leaveReasons) {
    /// This is leave reason section
    applyLeaveForm?.reasonID = leaveReasons![index!].reasonID;
  }

  void updateTimeDateData(BuildContext context, SelectedDateTime? timeDate) {
    if(timeDate?.calenderTimeEnum == CalenderTimeEnum.timeStart)
    {
      applyLeaveForm?.timeStart = timeDate?.dateTime;
    }
    else if(timeDate?.calenderTimeEnum == CalenderTimeEnum.timeEnd)
    {
      applyLeaveForm?.timeEnd = timeDate?.dateTime;
    }
    else if(timeDate?.calenderTimeEnum == CalenderTimeEnum.calenderStart)
    {
     // PrintLogs.print('dateeev ${timeDate?.dateTime}');
      applyLeaveForm?.dateStart = timeDate?.dateTime;
    }
    else if(timeDate?.calenderTimeEnum == CalenderTimeEnum.calenderEnd)
    {
      applyLeaveForm?.dateEnd = timeDate?.dateTime;
    }
    else if(timeDate?.calenderTimeEnum == CalenderTimeEnum.calenderSelect)
    {
      applyLeaveForm?.dateSelect = timeDate?.dateTime;
    }
  }
  void removeTimeDateData(BuildContext context, SelectedDateTime? timeDate) {
    if(timeDate?.calenderTimeEnum == CalenderTimeEnum.timeStart)
    {
      applyLeaveForm?.timeStart = null;
    }
    else if(timeDate?.calenderTimeEnum == CalenderTimeEnum.timeEnd)
    {
      applyLeaveForm?.timeEnd = null;
    }
    else if(timeDate?.calenderTimeEnum == CalenderTimeEnum.calenderStart)
    {
      applyLeaveForm?.dateStart = null;
    }
    else if(timeDate?.calenderTimeEnum == CalenderTimeEnum.calenderEnd)
    {
      applyLeaveForm?.dateEnd = null;
    }
    else if(timeDate?.calenderTimeEnum == CalenderTimeEnum.calenderSelect)
    {
      applyLeaveForm?.dateSelect = null;
    }
  }

  void saveFiles(List<GetFileType> files)
  {
    fileTypes = files;
  }

  Future fillData(BuildContext context) async
  {
    /// ==============Here Data is filling===============
    /// Company code employee code is taking from user data of login
    PrintLogs.printLogs('Fileee ${fileTypes?.length}');
    /// checking files if files list is not empty then populate files in applyleaveform
    if(fileTypes!=null&&fileTypes!.isNotEmpty)
      {
        List<AttachmentData> attachmentData = List.empty(growable: true);
        for(var data in fileTypes!)
          {
            attachmentData.add(AttachmentData(fileName: data.uploadedResultSet?.docName));
          }
        applyLeaveForm?.attachmentData = attachmentData;
      }
    /// Checking Leave type (Compensatory, Official, Paid )because leave type is must
    if(applyLeaveForm?.leaveTypeCode!=null)
      {
        // if(leaveCreateFormResultSet?.leaveType![index!].emergencyContact==true&&(applyLeaveForm?.phoneNumber==null||(applyLeaveForm?.phoneNumber!=null&&applyLeaveForm!.phoneNumber!.isEmpty)))
        //   {
        //   //  ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'${CallSettingsKeyWords.get(context, LanguageCodes.emergencyPhoneError)}',color: MyColor.colorRed));
        //   }
        // else{
          /// top check has to be leave reason then further change it later
          /// We have to check this(applyLeaveForm?.halfLeaveTypeID == 0&&applyLeaveForm?.fullDayLeave == 0) if true
          /// means its by time because if its type is time then we have to convert it in the following way
          /// we know 1.0 net balance means full day which is of 24 hour
          /// and half day is of 0.5 net balance which is of 12 hour
          /// so calculate total minutes but don't do anything with original TotalLeaves because we are assigning
          /// minutes if type is time and days if type is fullDay and 0.5 if type is halfday

        GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
        GetLeaveBalanceResultSet? getLeaveBalanceResultSet = getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet;

        if(applyLeaveForm?.halfLeaveTypeID == 0&&applyLeaveForm?.fullDayLeave == 0)
            {
              PrintLogs.printLogs('filday');
              int? totalMinutes = GetDateFormats().formatCalculateTime(applyLeaveForm!.timeStart!,applyLeaveForm!.timeEnd!);
              //double totalMin = 24 * 60;
              //PrintLogs.print('filday ${totalMinutes!/totalMin} $totalMin $totalMinutes');

              applyLeaveForm?.totalLeavesBalanceCalculator = double.parse(totalMinutes.toString());
              applyLeaveForm?.totalLeaves = double.parse(totalMinutes.toString());
              applyLeaveForm!.leaveFrom = '${GetDateFormats().formatIntoYYYYMMDDDate(applyLeaveForm!.dateSelect!)} ${GetDateFormats().formatInto24HourTime(applyLeaveForm!.timeStart!)}';
              applyLeaveForm!.leaveTo = '${GetDateFormats().formatIntoYYYYMMDDDate(applyLeaveForm!.dateSelect!)} ${GetDateFormats().formatInto24HourTime(applyLeaveForm!.timeEnd!)}';

            }
          else if(applyLeaveForm?.halfLeaveTypeID == 0)
          {
            PrintLogs.printLogs('halfday');
            ///Checking if User selected fullDay then days need to be calculated
            /// In 'calculateTFormDate' method we are calculating total number of holidays user has asked for
            /// also we are check if said includeUserWeekEnd == False then we have to check which user's day is ON and
            /// OFF so we will calculate total holidays according to user ON and OFF day lets say if saturday is OFF then
            /// we will not consider that day count in totalDays for leave. If includeUserWeekEnd == true then we will
            /// not check Holiday days and will include those day in total days leave
            int? totalDays;
            if(getLeaveBalanceResultSet?.deductWorkingWeekend!=null&&getLeaveBalanceResultSet?.deductWorkingWeekend==true&&leaveCreateFormResultSet?.companySetting!=null&&leaveCreateFormResultSet?.companySetting?.companyWeekend!=null)
              {
                /// First we are calculating if user holidays are fixed (deductWorkingWeekend == true) so it will cut according to fixed days now
                /// scenario ye hy k if total has applied for 6 days and he is allowed to do 2 leaves in a week
                /// then only 5 days balance will be deducted no for 6 days
                int daysUserAskedFor = GetDateFormats().daysTotalDaysBetween(applyLeaveForm!.dateStart!, applyLeaveForm!.dateEnd!);
                totalDays = daysUserAskedFor - GetDateFormats().getDeductWeekendDays(daysUserAskedFor,leaveCreateFormResultSet!.companySetting!.companyWeekend!);
              }
            else
              {
                totalDays = GetDateFormats().calculateTFormDate(applyLeaveForm!.dateStart!, applyLeaveForm!.dateEnd!,leaveCreateFormResultSet?.shiftInfo,getLeaveBalanceResultSet?.includeWeedend);
                PrintLogs.printLogs('totaldayyyy $totalDays');
                if(totalDays==0) {
                  totalDays = 1;
                } else {
                  totalDays ??= 1;
                }
              }
            if(applyLeaveForm?.timeStart!=null)
            {
              applyLeaveForm!.leaveFrom = '${GetDateFormats().formatIntoYYYYMMDDDate(applyLeaveForm!.dateStart!)} ${GetDateFormats().formatInto24HourTime(applyLeaveForm!.timeStart!)}';
              applyLeaveForm!.leaveTo = '${GetDateFormats().formatIntoYYYYMMDDDate(applyLeaveForm!.dateEnd!)} ${GetDateFormats().formatInto24HourTime(applyLeaveForm!.timeEnd!)}';
            }
            else{
              applyLeaveForm!.leaveFrom = '${GetDateFormats().formatIntoYYYYMMDDDate(applyLeaveForm!.dateStart!)}';
              applyLeaveForm!.leaveTo = '${GetDateFormats().formatIntoYYYYMMDDDate(applyLeaveForm!.dateEnd!)}';
            }
            applyLeaveForm?.totalLeaves = double.parse(totalDays.toString());
            applyLeaveForm?.totalLeavesBalanceCalculator = double.parse(totalDays.toString());

          }
          else
          {
            PrintLogs.printLogs('elseeetimeeee');
            if(applyLeaveForm?.timeStart!=null)
            {
              applyLeaveForm!.leaveFrom = '${GetDateFormats().formatIntoYYYYMMDDDate(applyLeaveForm!.dateSelect!)} ${GetDateFormats().formatInto24HourTime(applyLeaveForm!.timeStart!)}';
              applyLeaveForm!.leaveTo = '${GetDateFormats().formatIntoYYYYMMDDDate(applyLeaveForm!.dateSelect!)} ${GetDateFormats().formatInto24HourTime(applyLeaveForm!.timeEnd!)}';
            }
            else{
              applyLeaveForm!.leaveFrom = '${GetDateFormats().formatIntoYYYYMMDDDate(applyLeaveForm!.dateSelect!)}';
              applyLeaveForm!.leaveTo = '${GetDateFormats().formatIntoYYYYMMDDDate(applyLeaveForm!.dateSelect!)}';
            }
            ///if user selected half day then only 1 will be send
            int? index = leaveCreateFormResultSet?.halfLeaveDropdown?.indexWhere((element) => element.iD == applyLeaveForm?.halfLeaveTypeID);
            if(index!=null&&index!=-1)
              {
                double value = double.parse(leaveCreateFormResultSet?.halfLeaveDropdown?[index].remarks??'0.5');
                applyLeaveForm?.totalLeaves = value;
                applyLeaveForm?.totalLeavesBalanceCalculator = value;
              }
            else
              {
                applyLeaveForm?.totalLeaves = 0.5;
                applyLeaveForm?.totalLeavesBalanceCalculator = 0.5;
              }
          }
          // LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
          // dynamic companyCode = loginResultSet.headerInfo!.companyCode;
          // dynamic employeeCode = loginResultSet.headerInfo!.employeeCode;

          /// When user want to check other employees timeOff then we will check either user has selected an employee
          EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

          applyLeaveForm?.employeeCode = employeeInfoMapper.employeeCode;
          applyLeaveForm?.companyCode = employeeInfoMapper.companyCode;

        //}
      }
    else
      {
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.leaveTypeMustSelect)}');
       // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
      }
  }
  Future? start(BuildContext context,var map)
  async {

    initLoader();

    PrintLogs.printLogs('leaceee ${jsonEncode(map)}');
    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().postLeaveApiApi(context,map);
    await Future.delayed(const Duration(milliseconds: 100));
    await closeLoader();
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      leaveApplyJson = apiResponse.data;
      try{
        SnackBarDesign.happySnack(leaveApplyJson!.message!);
      }catch(e){}
      Future.delayed(const Duration(milliseconds: 200),(){
        Navigator.pop(context,true);
      });
    }
    else
    {
      ShowErrorMessage.show(apiResponse);
     // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'Unknown Error',color: MyColor.colorRed));
    }
  }

  ///---------------------- Leave Checks
  ///
  /// Check Either user total balance need to be deducted if yes then deduct
  bool? checkDeduction(BuildContext context)
  {
    /// If deduction is true then only we can check negative leaves concept

    GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
    GetLeaveBalanceResultSet? getLeaveBalanceResultSet = getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet;

    PrintLogs.printLogs('hang');
    if(getLeaveBalanceResultSet?.autoLeaveBalanceDeduction==null||getLeaveBalanceResultSet!=null&&getLeaveBalanceResultSet.autoLeaveBalanceDeduction==false)
      {
        PrintLogs.printLogs('falsehang');
        return false;
      }
    return checkNegativeBalance(context);

  }
  /// is user allowed negative balance
  bool? checkNegativeBalance(BuildContext context)
  {
    //PrintLogs.print('checkhang');
    GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
    GetLeaveBalanceResultSet? getLeaveBalanceResultSet = getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet;
    if(getLeaveBalanceResultSet?.autoUnpaid==null||getLeaveBalanceResultSet?.autoUnpaid==false)
    {
      PrintLogs.printLogs('iffalsehang');
      if(getLeaveBalanceResultSet?.allowNegativeBalance==true)
        {
          double? allowedTotalNegative = getLeaveBalanceResultSet?.maxAllowedBalanceInDay;
          double? cal;
          cal = applyLeaveForm!.totalLeavesBalanceCalculator! - getLeaveBalanceResultSet!.netBalance!;

          if(cal.isNegative||cal == 0)
          {
            return false;
          }
          else
          {
            double nowTotal = cal - allowedTotalNegative!;
            if(nowTotal.isNegative || nowTotal == 0)
            {
              return false;
            }
            else
            {
              return true;
            }
          }
        }
      else
        {
          PrintLogs.printLogs('yoooo ${applyLeaveForm!.totalLeavesBalanceCalculator}');
          double? cal = applyLeaveForm!.totalLeavesBalanceCalculator! - getLeaveBalanceResultSet!.netBalance!;
          if(cal.isNegative||cal==0)
            {
              return false;
            }
          else
            {
              return true;
            }
        }
    }
    return false;
  }
  /// checkUnPaid again if true

  AutoUnpaidCheck? checkUnpaidBalance(BuildContext context)
  {
    GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
    GetLeaveBalanceResultSet? getLeaveBalanceResultSet = getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet;
    if(getLeaveBalanceResultSet?.autoUnpaid!=null&&getLeaveBalanceResultSet?.autoUnpaid==true)
    {
      PrintLogs.printLogs('ififcheckhang ${getLeaveBalanceResultSet?.allowNegativeBalance}');
      if(getLeaveBalanceResultSet?.allowNegativeBalance==true)
      {
        PrintLogs.printLogs('abdrififcheckhang');
        double? allowedTotalNegative = getLeaveBalanceResultSet!.maxAllowedBalanceInDay;
        double? cal;
        PrintLogs.printLogs('Unpadidiffalsehangds ${allowedTotalNegative} ${getLeaveBalanceResultSet.netBalance}');
        cal = getLeaveBalanceResultSet.netBalance! + allowedTotalNegative!;
        PrintLogs.printLogs('Unpadidiffalsehangds ${cal}');
        double nowTotal = applyLeaveForm!.totalLeavesBalanceCalculator! - cal;
        PrintLogs.printLogs('Unpadidiffalsehang ${nowTotal}');
        if(nowTotal>0)
          {
            return AutoUnpaidCheck(true,nowTotal);
          }
        else
          {
            return AutoUnpaidCheck(false,nowTotal);
          }
      }
      else
        {
          PrintLogs.printLogs('ififcheckhang');
          return AutoUnpaidCheck(true, applyLeaveForm!.totalLeavesBalanceCalculator);
        }
    }
    else
      {
        return AutoUnpaidCheck(true, applyLeaveForm!.totalLeavesBalanceCalculator);
      }
  }

  /// check is by date or time

  bool? checkDateIsAfter(String startDate,String endDate)
  {
    return GetDateFormats().dateIsAfter(startDate, endDate);
  }
  bool? checkIsByDate(BuildContext context)
  {
    GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
    GetLeaveBalanceResultSet? getLeaveBalanceResultSet = getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet;
    PrintLogs.printLogs('unittt ${getLeaveBalanceResultSet?.unitID} ${GetVariable.isDate}');
    if(getLeaveBalanceResultSet!=null&&getLeaveBalanceResultSet.unitID == GetVariable.isDate)
      {
        return false;
      }
    return true;
  }
  bool? checkIsByTime(BuildContext context)
  {
    GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
    GetLeaveBalanceResultSet? getLeaveBalanceResultSet = getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet;
    //PrintLogs.print('timeee ${getLeaveBalanceResultSet!.unitID} ${GetVariable.isTime}');
    if(getLeaveBalanceResultSet!=null&&getLeaveBalanceResultSet.unitID == GetVariable.isTime)
    {
      return true;
    }
    return false;
  }
  bool? checkRemarks(BuildContext context)
  {
    GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
    GetLeaveBalanceResultSet? getLeaveBalanceResultSet = getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet;
    //PrintLogs.print('reasonyeee ${applyLeaveForm?.remarks}');
    if(getLeaveBalanceResultSet?.leaveReasonRequired==null||getLeaveBalanceResultSet?.leaveReasonRequired==false||getLeaveBalanceResultSet?.leaveReasonRequired==true&&applyLeaveForm?.remarks!=null&&applyLeaveForm!.remarks!.isNotEmpty)
    {
      return false;
    }
    return true;
  }
  bool? checkEmergencyContactNumberRequired(BuildContext context)
  {
    if(leaveCreateFormResultSet?.leaveType![index!].emergencyContact==true&&(applyLeaveForm?.phoneNumber==null||(applyLeaveForm?.phoneNumber!=null&&applyLeaveForm!.phoneNumber!.isEmpty)))
    {
      return true;
    }
    return false;
  }
  bool? supportDocument(BuildContext context)
  {
    GetLeaveBalanceJsonModelListener getLeaveBalanceResultSet = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
    int? minLeave = getLeaveBalanceResultSet.getLeaveBalanceResultSet?.minLeave;
    int? minDocuments = getLeaveBalanceResultSet.getLeaveBalanceResultSet?.documentNoRequired;
    //PrintLogs.print('fileeee ${fileTypes!.length} ${minLeave!} $minDocuments');
    if(getLeaveBalanceResultSet.getLeaveBalanceResultSet?.supportDocRequired==null||getLeaveBalanceResultSet.getLeaveBalanceResultSet?.supportDocRequired==false||getLeaveBalanceResultSet.getLeaveBalanceResultSet?.supportDocRequired==true)
      {
        /// if total leaves are shorter than minn leave then we donot need to check that either user has
        /// uploaded a document
        if(minLeave==null||applyLeaveForm!.totalLeavesBalanceCalculator!<minLeave)
          {
            return false;
          }
        else if(minLeave==null||minDocuments==null||applyLeaveForm!.totalLeavesBalanceCalculator!>=minLeave&&fileTypes!=null&&fileTypes!.length>=minDocuments)
        {
          /// but if total leaves are greater of equal to min leaves then we have to check that how many documents
          /// should be uploaded by user and either he has uploaded those number of files if yes then let it go
          return false;
        }
        else
          {
            /// Otherwise stop user and ask him to upload files
            return true;
          }
      }
    return true;
  }
  bool? allowHolidayPerYear(BuildContext context)
  {
    GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
    GetLeaveBalanceResultSet? getLeaveBalanceResultSet = getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet;
    //PrintLogs.print('getLeaveBalanceResultSet ${getLeaveBalanceResultSet?.availmentUnit} ${getLeaveBalanceResultSet?.noOfTimeInYear}');
    if((getLeaveBalanceResultSet?.noOfTimeInYear!=null&&getLeaveBalanceResultSet?.availmentUnit!=null&&getLeaveBalanceResultSet!.availmentUnit!<=getLeaveBalanceResultSet.noOfTimeInYear&&applyLeaveForm!.totalLeavesBalanceCalculator!<=getLeaveBalanceResultSet.noOfTimeInYear!)||getLeaveBalanceResultSet?.noOfTimeInYear==null||getLeaveBalanceResultSet?.availmentUnit==null)
    {
      //PrintLogs.print('getLeaveBalanceResultSet ${getLeaveBalanceResultSet?.availmentUnit} ${getLeaveBalanceResultSet?.noOfTimeInYear}');
      return false;
    }
    return true;
  }

  bool? allowHolidayInService(BuildContext context)
  {
    GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
    GetLeaveBalanceResultSet? getLeaveBalanceResultSet = getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet;
    if((getLeaveBalanceResultSet?.noOfTimeInService!=null&&getLeaveBalanceResultSet?.noOfTimeInService<=getLeaveBalanceResultSet?.totalLeaveAvailInService&&applyLeaveForm!.totalLeavesBalanceCalculator!<getLeaveBalanceResultSet!.totalLeaveAvailInService!)||getLeaveBalanceResultSet?.noOfTimeInService==null||getLeaveBalanceResultSet?.totalLeaveAvailInService==null)
    {
      return false;
    }
    return true;
  }
  bool? allowMinMaxLeave(BuildContext context)
  {
    GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
    GetLeaveBalanceResultSet? getLeaveBalanceResultSet = getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet;
    if(
    getLeaveBalanceResultSet?.minimumUnitValue==null||
    getLeaveBalanceResultSet?.minimumUnitValue!=null&&applyLeaveForm!.totalLeavesBalanceCalculator!>=double.parse(getLeaveBalanceResultSet!.minimumUnitValue.toString())
    &&getLeaveBalanceResultSet.maximumUnitValue!=null&&applyLeaveForm!.totalLeavesBalanceCalculator!<=double.parse(getLeaveBalanceResultSet.maximumUnitValue.toString())
    )
    {
      return false;
    }
    return true;
  }

  void clearAll() {
    applyLeaveForm = null;
    remarksController.clear();
    numberController.clear();
    emergencyNameController.clear();
    applyLeaveForm = ApplyLeaveForm();
    if(fileTypes!=null)
      {
        int length = fileTypes!.length;
        fileTypes?.removeRange(1, length);
      }
    else{
      PrintLogs.printLogs('nulllllldsfasdgafdsga');
    }
  }
  // bool? needLeaveReason(BuildContext context)
  // {
  //   GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
  //   GetLeaveBalanceResultSet? getLeaveBalanceResultSet = getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet;
  //   if(getLeaveBalanceResultSet?.leaveReasonRequired==null||getLeaveBalanceResultSet?.leaveReasonRequired==false||getLeaveBalanceResultSet?.leaveReasonRequired==true&&applyLeaveForm?.remarks!=null&&applyLeaveForm!.remarks!.isNotEmpty)
  //   {
  //     return false;
  //   }
  //   return true;
  // }
}
class AutoUnpaidCheck{
  bool? done;
  double? checkBalance;
  AutoUnpaidCheck(this.done,this.checkBalance);
}