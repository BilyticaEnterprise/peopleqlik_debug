import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/submit_time_off_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/get_time_off_leave_balance_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/get_time_off_form_data_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/time_off_add_edit_attachments_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/UploadFileListener/upload_file_listener.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/SearchEmployeePanelPages/panel_header.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TimeOffPage/TimeOffSubPages/AddEditTimeOffPages/attachmentfiles.dart';
import 'package:peopleqlik_debug/utils/Buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/calendars/calender_time_widget.dart';
import 'package:peopleqlik_debug/utils/ScreenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/DropDowns/LegacyDropdown/header_dropdown.dart';
import 'package:peopleqlik_debug/utils/TextFields/LegacyTextFields/header_textfield.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/utils/TextFields/LegacyTextFields/text_widgets.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:peopleqlik_debug/utils/double_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/pop_ups.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../../../../utils/Appbars/generic_app_bar.dart';
import '../../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../../../../../Version1/views/BottomBarPages/GlobalEmployeeSearchUi/call_employee_search_ui.dart';

class TimeOffAddEdit extends StatefulWidget {
  TimeOffAddEdit({Key? key}) : super(key: key);

  @override
  State<TimeOffAddEdit> createState() => _TimeOffAddEditState();
}

class _TimeOffAddEditState extends State<TimeOffAddEdit> {

  @override
  Widget build(BuildContext context) {
    Provider.of<GlobalSelectedEmployeeController>(context,listen: false).saveTempEmployee();
    return WillPopScope(
      onWillPop: ()async{
        Provider.of<GlobalSelectedEmployeeController>(context,listen: false).specialPop(context);
        return false;
      },
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider<TimeOffAddEditAttachments>(create: (_) => TimeOffAddEditAttachments()),
            ChangeNotifierProvider<GetLeaveFormModelListener>(create: (_) => GetLeaveFormModelListener(),),
            ChangeNotifierProvider<AddTimeOffCollector>(create: (_) => AddTimeOffCollector()),
            ChangeNotifierProvider<GetLeaveBalanceJsonModelListener>(create: (_) => GetLeaveBalanceJsonModelListener())
          ],
          builder: (context, snapshot) {
            return GetPageStarterScaffoldStateLess(
              body: BodyData(),
              appBar: Consumer<GlobalSelectedEmployeeController>(
                  builder: (context, employeeData, child) {
                    return EmployeeAppBarWidget(
                      CallLanguageKeyWords.get(context, LanguageCodes.TimeOffAppBar)??'',
                      onBackTap: (){
                        Provider.of<GlobalSelectedEmployeeController>(context,listen: false).specialPop(context);
                      },
                      selectEmployeeTap: () {
                        EmployeeSearchBottomSheet().show(
                            context,
                                (employeeInfoMapper)
                            {
                              Provider.of<GetLeaveFormModelListener>(context, listen: false).start(context);
                            }
                        );
                      },
                      removeEmployeeTap: () async {
                        await employeeData.resetEmployee();
                        Provider.of<GetLeaveFormModelListener>(context, listen: false).start(context);
                      },
                      hidePlusButton: true,
                      employeeInfoMapper: employeeData.getEmployee(),
                    );
                  }
              ),
            );
          }
      ),
    );
  }
}

class BodyData extends StatefulWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  late FocusScopeNode nodeFocus;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    nodeFocus = FocusScopeNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Provider.of<EmployeeSearchController>(context, listen: false).justUpdatePage(EmployeeCalledForPage.timeOffForm);
      Provider.of<GetLeaveFormModelListener>(context, listen: false).start(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddTimeOffCollector addTimeOffCollector = Provider.of<AddTimeOffCollector>(context,listen: false);
    return Consumer<GetLeaveFormModelListener>(builder: (context, data, child) {
      if (data.apiStatus == ApiStatus.done) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenSize(context).heightOnly( 1),
              ),
              Consumer<GetLeaveBalanceJsonModelListener>(
                  builder: (context, dataBalance, child) {
                if (dataBalance.apiStatus == ApiStatus.done) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
                    margin: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), 0, ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 1)),
                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(15)), color: const Color(MyColor.colorPrimary).withOpacity(0.1)),
                    child: RichText(
                      text: TextSpan(text: '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffCurrentBalanceh1)} : ', style: GetFont.get(context, color: MyColor.colorT4, fontSize: 1.8, fontWeight: FontWeight.w600), children: [
                        TextSpan(
                          text: '${DoubleFormat().format(dataBalance.getLeaveBalanceResultSet?.netBalance ?? 0.0)}\n',
                          style: GetFont.get(context, color: MyColor.colorBlack, fontSize: 2.2, fontWeight: FontWeight.w600),
                        ),
                        WidgetSpan(
                            child: SizedBox(
                              height: ScreenSize(context).heightOnly( 0.5),
                            )),
                        TextSpan(
                          text: '\n${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffCurrentBalanceh2)} : ',
                          style: GetFont.get(context, color: MyColor.colorBlack, fontSize: 1.4, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: '${dataBalance.getLeaveBalanceResultSet?.minimumUnitValue ?? '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffCurrnetBalanceh4)}'}\n',
                          style: GetFont.get(context, color: MyColor.colorGrey3, fontSize: 1.4, fontWeight: FontWeight.w400),
                        ),
                        WidgetSpan(
                            child: SizedBox(
                              height: ScreenSize(context).heightOnly( 0.3),
                            )),
                        TextSpan(
                          text: '\n${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffCurrentBalanceh3)} : ',
                          style: GetFont.get(context, color: MyColor.colorBlack, fontSize: 1.4, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: '${dataBalance.getLeaveBalanceResultSet?.maximumUnitValue ?? '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffCurrnetBalanceh4)}'}',
                          style: GetFont.get(context, color: MyColor.colorGrey3, fontSize: 1.4, fontWeight: FontWeight.w400),
                        )
                      ]),
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
                    margin: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), 0, ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 1)),
                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(15)), color: const Color(MyColor.colorPrimary).withOpacity(0.1)),
                    child: RichText(
                      text: TextSpan(text: '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffhint1)} \n', style: GetFont.get(context, color: MyColor.colorT4, fontSize: 1.6, fontWeight: FontWeight.w600), children: [
                        WidgetSpan(
                            child: SizedBox(
                              height: ScreenSize(context).heightOnly( 0.5),
                            )),
                        TextSpan(
                          text: '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffhint2)} ',
                          style: GetFont.get(context, color: MyColor.colorGrey3, fontSize: 1.4, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffhint3)}',
                          style: GetFont.get(context, color: MyColor.colorBlack, fontSize: 1.4, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: ' ${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffhint4)}',
                          style: GetFont.get(context, color: MyColor.colorGrey3, fontSize: 1.4, fontWeight: FontWeight.w400),
                        )
                      ]),
                    ),
                  );
                }
              }),
              SizedBox(
                height: ScreenSize(context).heightOnly( 2),
              ),
              HeaderDropDownField(DropDownDataType(DropDownTypeEnum.leaveType, data.leaveTypeList!), '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffhint5)}', dropDownCallBack, true, key: const Key('leaveType')),
              Consumer<GetLeaveBalanceJsonModelListener>(
                  builder: (context, dataBalance, child) {
                if (dataBalance.apiStatus == ApiStatus.done) {
                  // PrintLogs.printLogs('fulltypeee ${dataBalance.isFullDay}');
                  //PrintLogs.print('sadfsdfs ${data.leaveCreateFormResultSet?.leaveType?[data.getSelectedIndexLeaveType].typeCode} ${data.getSelectedIndexLeaveType}');
                  return Column(
                    children: [
                      if (dataBalance.leaveReasons != null && dataBalance.leaveReasons!.isNotEmpty && data.leaveCreateFormResultSet?.leaveType != null && data.leaveCreateFormResultSet?.leaveType![data.getSelectedIndexLeaveType].typeCode == dataBalance.leaveReasons![0].typeCode) ...[
                        SizedBox(
                          height: ScreenSize(context).heightOnly( 2),
                        ),
                        HeaderDropDownField(DropDownDataType(DropDownTypeEnum.leaveReason, dataBalance.leaveReasonList!), '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffLeaveReason)}', dropDownCallBack, true, key: const Key('leaveReason')),
                      ],
                      //if(data.getSelectedIndexLeaveType!=null&&data.leaveCreateFormResultSet?.leaveType!= null&&data.leaveCreateFormResultSet!.leaveType![data.getSelectedIndexLeaveType].onlyApplyForFullDay==false)...[
                      SizedBox(
                        height: ScreenSize(context).heightOnly( 2),
                      ),
                      HeaderDropDownField(DropDownDataType(DropDownTypeEnum.fullDay, data.halfLeaveList!), '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffFullDay)}', dropDownCallBack, true, key: const Key('fullDay')),
                      //],
                      SizedBox(
                        height: ScreenSize(context).heightOnly( 2),
                      ),
                      if (dataBalance.isFullDay != null && dataBalance.isFullDay == 2 && data.leaveCreateFormResultSet?.leaveType != null && data.leaveCreateFormResultSet!.leaveType![data.getSelectedIndexLeaveType].unitID == GetVariable.isTime) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                          child: CalenderTimeWidget(
                            CalenderTimeEnum.calenderSelect,
                            '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffSelectDate)}',
                            '${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterButton1)}',
                            dateTimeCallback,
                            true,
                            allowedPreviously: true,
                            key: const Key('selectDate'),
                          ),
                        ),
                        SizedBox(
                          height: ScreenSize(context).heightOnly( 2),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CalenderTimeWidget(
                                    CalenderTimeEnum.timeStart,
                                    '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffStartTime)}',
                                    '${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterButton1)}',
                                    dateTimeCallback,
                                    true,
                                    allowedPreviously: true,
                                    key: const Key('StartTimeHere'),
                                  )),
                              SizedBox(
                                width: ScreenSize(context).widthOnly( 3.5),
                              ),
                              Expanded(
                                  child: CalenderTimeWidget(
                                    CalenderTimeEnum.timeEnd,
                                    '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffEndTime)}',
                                    '${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterButton1)}',
                                    dateTimeCallback,
                                    true,
                                    allowedPreviously: true,
                                    key: const Key('EndTimeClickHere'),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenSize(context).heightOnly( 2),
                        ),
                      ],
                      // if(dataBalance.isFullDay!=null&&dataBalance.isFullDay == 2&&data.getSelectedIndexLeaveType!=null&&data.leaveCreateFormResultSet?.leaveType!= null&&data.leaveCreateFormResultSet!.leaveType![data.getSelectedIndexLeaveType].unitID==GetVariable.isDate)...
                      // [
                      //   ds
                      //   Padding(
                      //     padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                      //     child: CalenderTimeWidget(CalenderTimeEnum.calenderSelect,'${CallSettingsKeyWords.get(context, LanguageCodes.TimeOffSelectDate)}','${CallSettingsKeyWords.get(context, LanguageCodes.approvalFilterButton1)}',dateTimeCallback,false,key: const Key('selectDate'),),
                      //   ),
                      //   SizedBox(height: ScreenSize(context).heightOnly( 2),),
                      // ],
                      if (dataBalance.isFullDay != null && dataBalance.isFullDay == 1 && data.getSelectedIndexLeaveType != null && data.leaveCreateFormResultSet?.leaveType != null && data.leaveCreateFormResultSet!.leaveType![data.getSelectedIndexLeaveType].unitID == GetVariable.isDate) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                          child: CalenderTimeWidget(
                            CalenderTimeEnum.calenderStart,
                            '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffFromDate)}',
                            '${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterButton1)}',
                            dateTimeCallback,
                            true,
                            allowedPreviously: true,
                            key: Key('${addTimeOffCollector.datesKey}fromDate'),
                          ),
                        ),
                        SizedBox(
                          height: ScreenSize(context).heightOnly( 2),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                          child: CalenderTimeWidget(
                            CalenderTimeEnum.calenderEnd,
                            '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffToDate)}',
                            '${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterButton1)}',
                            dateTimeCallback,
                            true,
                            allowedPreviously: true,
                            key: Key('${addTimeOffCollector.datesKey}toDate'),
                          ),
                        ),
                        SizedBox(
                          height: ScreenSize(context).heightOnly( 2),
                        ),
                      ],
                      if (dataBalance.isFullDay != null && dataBalance.isFullDay == 3 && data.getSelectedIndexLeaveType != null && data.leaveCreateFormResultSet?.leaveType != null && data.leaveCreateFormResultSet!.leaveType![data.getSelectedIndexLeaveType].unitID == GetVariable.isDate) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                          child: CalenderTimeWidget(
                            CalenderTimeEnum.calenderSelect,
                            '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffSelectDate)}',
                            '${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterButton1)}',
                            dateTimeCallback,
                            true,
                            allowedPreviously: true,
                            key: Key('${addTimeOffCollector.datesKey}selectDate'),
                          ),
                        ),
                        SizedBox(
                          height: ScreenSize(context).heightOnly( 2),
                        ),
                      ],
                      HeaderTextField(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffEmerContact1)}',
                        '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffEmerContact2)}',
                        addTimeOffCollector.numberController,
                        nodeFocus,
                        data.leaveCreateFormResultSet?.leaveType?[data.getSelectedIndexLeaveType].emergencyContact,
                        callBack: phoneNumberCallback,
                        key: const Key('phoneKeyyy'),
                      ),
                      SizedBox(
                        height: ScreenSize(context).heightOnly( 2),
                      ),
                      HeaderTextField(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffEmerContact3)}',
                        '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffEmerContact4)}',
                        addTimeOffCollector.emergencyNameController,
                        nodeFocus,
                        false,
                        callBack: emergencyNameCallback,
                        key: const Key('nameKeyyy'),
                      ),
                      SizedBox(
                        height: ScreenSize(context).heightOnly( 2),
                      ),
                      HeaderTextField(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffAnyRemarks1)}',
                        '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffAnyRemarks2)}',
                        addTimeOffCollector.remarksController,
                        nodeFocus,
                        true,
                        callBack: remarksCallback,
                        key: const Key('RemarksKeyyyy'),
                      ),
                      SizedBox(
                        height: ScreenSize(context).heightOnly( 3),
                      ),
                      AttachmentFileWidget(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.pequestsaddFormAttachment)}',
                        picturesCallBack,
                        FileTypeServer.leave,
                        height: 24,
                        horizontalMargin: 2,
                        verticalMargin: 6,
                        key: const Key('attachments'),
                      ),
                      SizedBox(
                        height: ScreenSize(context).heightOnly( 6),
                      ),
                      ButtonWidget(
                        text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsaddFormButton)}',
                        buttonColor: MyColor.colorPrimary,
                        textSize: 2.2,
                        textColor: MyColor.colorWhite,
                        height: 6.5,
                        width: ScreenSize(context).widthOnly( 90),
                        paddingHorizontal: ScreenSize(context).heightOnly( 1.2),
                        weight: FontWeight.w600,
                        onPressed: confirmPressed,
                      ),
                      SizedBox(
                        height: ScreenSize(context).heightOnly( 10),
                      ),
                    ],
                  );
                } else if (dataBalance.apiStatus == ApiStatus.empty || dataBalance.apiStatus == ApiStatus.error) {
                  return Container();
                } else if (dataBalance.apiStatus == ApiStatus.started) {
                  return const CircularIndicatorCustomized(
                    size: 16,
                    marginTop: 5,
                    marginBottom: 0,
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        );
      } else if (data.apiStatus == ApiStatus.error || data.apiStatus == ApiStatus.empty) {
        return NotAvailable(
          '404anim',
          '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}',
          '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr10)}',
          topMargin: 8,
          width: 40,
        );
      } else {
        return const CircularIndicatorCustomized();
      }
    });
  }

  void phoneNumberCallback(String data) {
    Provider.of<AddTimeOffCollector>(context, listen: false).applyLeaveForm?.phoneNumber = data;
  }

  void emergencyNameCallback(String data) {
    Provider.of<AddTimeOffCollector>(context, listen: false).applyLeaveForm?.eCIName = data;
  }

  void remarksCallback(String data) {
    Provider.of<AddTimeOffCollector>(context, listen: false).applyLeaveForm?.remarks = data;
  }

  void picturesCallBack(List<GetFileType> getFiles) {
    Provider.of<AddTimeOffCollector>(context, listen: false).saveFiles(getFiles);
  }

  void dateTimeCallback(SelectedDateTime timeDate) {
    if (timeDate.dateTime == null) {
      Provider.of<AddTimeOffCollector>(context, listen: false).removeTimeDateData(context, timeDate);
    } else {
      Provider.of<AddTimeOffCollector>(context, listen: false).updateTimeDateData(context, timeDate);
    }
  }

  void dropDownCallBack(SelectedDropDown selectedDropDown) {
    //PrintLogs.print('${selectedDropDown.dropDownTypeEnum}');
    if (selectedDropDown.dropDownTypeEnum == DropDownTypeEnum.leaveType && selectedDropDown.index != null) {
      /// Here we are getting index and name of the selected LEAVE TYPE and then we are calling
      /// get balance of this leave type api
      GetLeaveFormModelListener getLeaveFormModelListener = Provider.of<GetLeaveFormModelListener>(context, listen: false);

      /// Updating halfDayFullDay dropdown data according to CHECKS given by API if he says user can apply
      /// only for full day then we have to show only fullDay option in dropdown otherwise we have to include
      /// 1st Half, 2nd Half options too
      getLeaveFormModelListener.updateHalfList(context, selectedDropDown);

      /// Also we are updating the selected index of Leave so that for later use we don't need to calculate
      /// index again and again
      getLeaveFormModelListener.updateSelectedLeaveTypeIndex(selectedDropDown.index!);

      Provider.of<AddTimeOffCollector>(context, listen: false).clearAll();

      /// Save data for submitting form data
      Provider.of<AddTimeOffCollector>(context, listen: false).saveDataForLogics(getLeaveFormModelListener.leaveCreateFormResultSet, selectedDropDown.index);

      try {
        Provider.of<GetLeaveBalanceJsonModelListener>(context, listen: false).start(
          context,
          '${getLeaveFormModelListener.leaveCreateFormResultSet?.leaveType?[selectedDropDown.index!].typeCode}',
          getLeaveFormModelListener.leaveCreateFormResultSet!.leaveCalander!.calendarCode!,
        );
      } catch (e) {
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError16)}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '', color: MyColor.colorRed));
      }

      /// Call api upon selected LeaveType Code
    } else if (selectedDropDown.dropDownTypeEnum == DropDownTypeEnum.fullDay && selectedDropDown.index != null) {
      Provider.of<AddTimeOffCollector>(context, listen: false).checkFullHalfDayType(context, selectedDropDown);
    } else if (selectedDropDown.dropDownTypeEnum == DropDownTypeEnum.leaveReason && selectedDropDown.index != null) {
      GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false);
      Provider.of<AddTimeOffCollector>(context, listen: false).checkLeaveReasonType(context, selectedDropDown.index, getLeaveBalanceJsonModelListener.leaveReasons);
    }
  }

  Future<void> confirmPressed() async {
    ///Check all these conditions before applying
    /// 1 -  If Time is selected both time need to be added start and end time
    /// 2 -
    AddTimeOffCollector addTimeOffCollector = Provider.of<AddTimeOffCollector>(context, listen: false);
    GetLeaveBalanceJsonModelListener getLeaveBalanceJsonModelListener = Provider.of<GetLeaveBalanceJsonModelListener>(context, listen: false);

    if (getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet == null) {
      SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.calenderError1)}');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '', color: MyColor.colorRed));
    } else {
      if (addTimeOffCollector.checkIsByTime(context) == true && addTimeOffCollector.applyLeaveForm?.timeStart == null) {
        PrintLogs.printLogs('errorrrr1');
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError2)}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError2)}', color: MyColor.colorRed));
      } else if (addTimeOffCollector.checkIsByTime(context) == true && addTimeOffCollector.applyLeaveForm?.timeEnd == null) {
        PrintLogs.printLogs('errorrrr2');
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError1)}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError1)}', color: MyColor.colorRed));
      } else if (addTimeOffCollector.checkIsByTime(context) == true && addTimeOffCollector.applyLeaveForm?.dateSelect == null) {
        PrintLogs.printLogs('errorrrr2');
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError5)}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError5)}', color: MyColor.colorRed));
      } else if (getLeaveBalanceJsonModelListener.leaveReasons != null && getLeaveBalanceJsonModelListener.leaveReasons!.isNotEmpty && getLeaveBalanceJsonModelListener.leaveReasons?.indexWhere((element) => element.typeCode == addTimeOffCollector.applyLeaveForm?.leaveTypeCode)!=-1 && addTimeOffCollector.applyLeaveForm?.reasonID == null) {
        PrintLogs.printLogs('errorrrr3');
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError3)}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError3)}', color: MyColor.colorRed));
      } else if (addTimeOffCollector.applyLeaveForm?.halfLeaveTypeID == null) {
        PrintLogs.printLogs('errorrrr4');
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError4)}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError4)}', color: MyColor.colorRed));
      } else if (addTimeOffCollector.checkIsByDate(context) == false && addTimeOffCollector.applyLeaveForm?.halfLeaveTypeID == 0 && (addTimeOffCollector.applyLeaveForm?.dateStart == null || addTimeOffCollector.applyLeaveForm?.dateEnd == null)) {
        PrintLogs.printLogs('errorrrr5');
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError5)}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError5)}', color: MyColor.colorRed));
      } else if (addTimeOffCollector.checkIsByDate(context) == false && addTimeOffCollector.applyLeaveForm?.halfLeaveTypeID != 0 && (addTimeOffCollector.applyLeaveForm?.dateSelect == null)) {
        // PrintLogs.printLogs('errorrrr6 ${addTimeOffCollector.checkIsByDate(context)} ${addTimeOffCollector.applyLeaveForm?.dateSelect} ${addTimeOffCollector.applyLeaveForm?.halfLeaveTypeID}');
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError4)}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError4)}', color: MyColor.colorRed));
      } else if (addTimeOffCollector.checkDateIsAfter(addTimeOffCollector.applyLeaveForm?.dateStart != null ? addTimeOffCollector.applyLeaveForm!.dateStart! : addTimeOffCollector.applyLeaveForm!.dateSelect!, addTimeOffCollector.applyLeaveForm?.dateEnd != null ? addTimeOffCollector.applyLeaveForm!.dateEnd! : addTimeOffCollector.applyLeaveForm!.dateSelect!) == false) {
        PrintLogs.printLogs('errorrrr55');
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError48)}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError48)}', color: MyColor.colorRed));
      }

      else if (addTimeOffCollector.checkEmergencyContactNumberRequired(context)==true) {
        PrintLogs.printLogs('errorrrr556');
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.emergencyPhoneError)}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'${CallLanguageKeyWords.get(context, LanguageCodes.emergencyPhoneError)}',color: MyColor.colorRed));
      }
      else {

        await addTimeOffCollector.fillData(context);

        if (addTimeOffCollector.checkDeduction(context) == true) {
          PrintLogs.printLogs('errorrrr11');
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError6)}');
          // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError6)}', color: MyColor.colorRed));
        } else if (addTimeOffCollector.allowMinMaxLeave(context) == true) {
          PrintLogs.printLogs('errorrrr12');
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError7)}');
          // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError7)}', color: MyColor.colorRed));
        } else if (addTimeOffCollector.supportDocument(context) == true) {
          PrintLogs.printLogs('errorrrr13');
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError8)}');
          // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError8)} ${addTimeOffCollector.applyLeaveForm?.totalLeavesBalanceCalculator} ${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError9)} ${getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet?.documentNoRequired} ${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError10)}', color: MyColor.colorRed));
        } else if (addTimeOffCollector.checkRemarks(context) == true) {
          PrintLogs.printLogs('errorrrr14');
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError11)}');
          // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError11)}', color: MyColor.colorRed));
        } else if (addTimeOffCollector.allowMinMaxLeave(context) == true) {
          PrintLogs.printLogs('errorrrr15');
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError12)}');
          // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError12)}', color: MyColor.colorRed));
        } else if (addTimeOffCollector.allowHolidayPerYear(context) == true) {
          PrintLogs.printLogs('errorrrr16');
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError13)}');
          // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError13)} ${getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet?.noOfTimeInYear} ${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError14)}', color: MyColor.colorRed));
        } else if (addTimeOffCollector.allowHolidayInService(context) == true) {
          PrintLogs.printLogs('errorrrr17');
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError13)}');
          // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context, '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError13)} ${getLeaveBalanceJsonModelListener.getLeaveBalanceResultSet?.noOfTimeInService} ${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError15)}', color: MyColor.colorRed));
        }
        else if (addTimeOffCollector.checkUnpaidBalance(context)?.done == true)
        {
          PrintLogs.printLogs('errorrrr19  ${addTimeOffCollector.checkUnpaidBalance(context)?.checkBalance}');
          bool check = await AutoUnPaid().show(context, addTimeOffCollector.checkUnpaidBalance(context)!);

          if (check == true) {
            if (addTimeOffCollector.numberController.text.isNotEmpty) {
              addTimeOffCollector.applyLeaveForm?.eCINumber = addTimeOffCollector.numberController.text;
            }
            if (addTimeOffCollector.remarksController.text.isNotEmpty) {
              addTimeOffCollector.applyLeaveForm?.remarks = addTimeOffCollector.remarksController.text;
            }
            if (addTimeOffCollector.emergencyNameController.text.isNotEmpty) {
              addTimeOffCollector.applyLeaveForm?.eCIName = addTimeOffCollector.emergencyNameController.text;
            }

            /// start apply from here
            if (addTimeOffCollector.applyLeaveForm?.attachmentData != null) {
              addTimeOffCollector.applyLeaveForm?.attachmentData?.removeAt(0);
            }
            addTimeOffCollector.applyLeaveForm?.approvalStatusID = 1;

            addTimeOffCollector.start(context, addTimeOffCollector.applyLeaveForm?.toJson());
          }
        } else {
          PrintLogs.printLogs('errorrrr19');
          if (addTimeOffCollector.numberController.text.isNotEmpty) {
            addTimeOffCollector.applyLeaveForm?.eCINumber = addTimeOffCollector.numberController.text;
          }
          if (addTimeOffCollector.remarksController.text.isNotEmpty) {
            addTimeOffCollector.applyLeaveForm?.remarks = addTimeOffCollector.remarksController.text;
          }
          if (addTimeOffCollector.emergencyNameController.text.isNotEmpty) {
            addTimeOffCollector.applyLeaveForm?.eCIName = addTimeOffCollector.emergencyNameController.text;
          }

          /// start apply from here
          if (addTimeOffCollector.applyLeaveForm?.attachmentData != null) {
            addTimeOffCollector.applyLeaveForm?.attachmentData?.removeAt(0);
          }
          addTimeOffCollector.applyLeaveForm?.approvalStatusID = 1;
          addTimeOffCollector.start(context, addTimeOffCollector.applyLeaveForm?.toJson());
        }
      }
    }
    //PrintLogs.print('leave type ${addTimeOffCollector.applyLeaveForm?.timeStart} ${addTimeOffCollector.checkIsByTime(context)}');
  }
}
