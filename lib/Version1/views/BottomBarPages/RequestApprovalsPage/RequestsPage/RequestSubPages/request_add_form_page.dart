import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/RequestFormWidgets/request_checkbox.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/RequestFormWidgets/request_datepicker.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/RequestFormWidgets/request_multiple_dropdown.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/RequestFormWidgets/request_textfield.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/request_form_get_listener.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/utils/Enums/request_enums.dart';

import 'package:peopleqlik_debug/Version1/viewModel/Requests/save_request_form_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/time_off_add_edit_attachments_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/UploadFileListener/upload_file_listener.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/SearchEmployeePanelPages/panel_header.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TimeOffPage/TimeOffSubPages/AddEditTimeOffPages/attachmentfiles.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/hide_keyboard.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../Version1/models/RequestsModel/request_data_taker.dart';
import '../../../../../../utils/Appbars/generic_app_bar.dart';
import '../../../../../../utils/Reuse_LogicalWidgets/current_employee_name_note.dart';
import '../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../viewModel/Requests/RequestSubListListeners/RequestFormWidgets/request_drop_down.dart';
import '../../../GlobalEmployeeSearchUi/call_employee_search_ui.dart';

class RequestAddFormPage extends StatelessWidget {
  RequestAddFormPage({Key? key,}) : super(key: key);

  RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    Provider.of<GlobalSelectedEmployeeController>(context,listen: false).saveTempEmployee();
    requestDataTaker = ModalRoute.of(context)!.settings.arguments as RequestDataTaker;
    return WillPopScope(
      onWillPop: ()async{
        Provider.of<GetRequestFormListener>(context,listen: false).formList.clear();
        Provider.of<GetRequestFormListener>(context,listen: false).requestFormResultSet = null;
        Provider.of<GetRequestFormListener>(context,listen: false).apiStatus = ApiStatus.nothing;
        Provider.of<GetRequestFormListener>(context,listen: false).encodedRequest = null;
        Provider.of<GlobalSelectedEmployeeController>(context,listen: false).specialPop(context);
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<TimeOffAddEditAttachments>(create: (_) => TimeOffAddEditAttachments()),
          Provider<SaveRequestFormListener>(create: (_) => SaveRequestFormListener())
        ],
        child: GestureDetector(
          onTap: (){HideShowKeyboard.hide(context);},
          child: GetPageStarterScaffoldStateLess(
              body: BodyData(requestDataTaker),
              appBar: Consumer<GlobalSelectedEmployeeController>(
                  builder: (context, employeeData, child) {
                    return EmployeeAppBarWidget(
                      requestDataTaker?.title??'',
                      onBackTap: (){
                        Provider.of<GlobalSelectedEmployeeController>(context,listen: false).specialPop(context);
                      },
                      selectEmployeeTap: () {
                        EmployeeSearchBottomSheet().show(
                            context,
                                (employeeInfoMapper)
                            {
                              Provider.of<GetRequestFormListener>(context,listen:false).start(context, requestDataTaker?.id);
                            }
                        );
                      },
                      removeEmployeeTap: () async {
                        await employeeData.resetEmployee();
                        Provider.of<GetRequestFormListener>(context,listen:false).start(context, requestDataTaker?.id);
                      },
                      hidePlusButton: true,
                      employeeInfoMapper: employeeData.getEmployee(),
                    );
                  }
              ),
              checkEmployeeIfExistInCurrentCompany: Provider.of<GlobalSelectedEmployeeController>(context,listen: false).checkIfCurrentUserCompanyMatches(),
              employeeChangeCurrentCompanyTap: (){
                EmployeeSearchBottomSheet().show(
                    context,
                        (employeeInfoMapper)
                    {
                      Provider.of<GetRequestFormListener>(context,listen:false).start(context, requestDataTaker?.id);
                    }
                );
              }
          ),
        ),
      ),
    );
  }
}
class BodyData extends StatefulWidget {
  final RequestDataTaker? requestDataTaker;
  const BodyData(this.requestDataTaker, {Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)
    {
      // RequestDataTaker? requestDataTaker = RequestDataTaker(widget.requestDataTaker!.id, widget.requestDataTaker!.title,requestsEnum: RequestsEnum.generalRequestForm);
      // Provider.of<EmployeeSearchController>(context,listen: false).requestDataTaker = requestDataTaker;
      // Provider.of<EmployeeSearchController>(context,listen: false).justUpdatePage(EmployeeCalledForPage.generalForm);
      Provider.of<GetRequestFormListener>(context,listen:false).start(context, widget.requestDataTaker?.id);
    }
    );
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<GetRequestFormListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return BodyDataNow(data);
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
          }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
}
class BodyDataNow extends StatefulWidget {
  final GetRequestFormListener? data;
  const BodyDataNow(this.data, {Key? key}) : super(key: key);

  @override
  State<BodyDataNow> createState() => _BodyDataNowState();
}

class _BodyDataNowState extends State<BodyDataNow> {
  FocusScopeNode? scopeNode;
  @override
  void initState() {
    scopeNode = FocusScopeNode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetRequestFormListener>(
        builder: (context,data,child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CurrentEmployeeNoteWidget(),
                Flexible(
                  child: ListView.separated(
                      padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 2),bottom: ScreenSize(context).heightOnly( 6)),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)
                      {
                        return getWidget(data.formList[index], index);
                      },
                      separatorBuilder: (context,index)
                      {
                        return SizedBox(height: ScreenSize(context).heightOnly( 2),);
                      },
                      itemCount: data.formList.length
                  ),
                ),
                //SizedBox(height:ScreenSize(context).heightOnly(4),),
                AttachmentFileWidget('${CallLanguageKeyWords.get(context, LanguageCodes.pequestsaddFormAttachment)}',picturesCallBack,FileTypeServer.request,height: 24,horizontalMargin: 2,topMargin:6,bottomMargin: 8,key: const Key('attachmentsRequest'),),
                SizedBox(height: ScreenSize(context).heightOnly( 3),),
                ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsaddFormButton)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: confirmPressed,),
                SizedBox(height:ScreenSize(context).heightOnly(6),),
              ],
            ),
          );
        }
    );
  }
  void picturesCallBack(List<GetFileType> file)
  {
    Provider.of<GetRequestFormListener>(context,listen: false).updateFileData(file);
  }
  void confirmPressed()
  {
    Provider.of<GetRequestFormListener>(context,listen: false).submit(context);
  }
  Widget getWidget(FormData? data,int uiIndex)
  {
    //PrintLogs.print('get widget');
    switch (data!.uiTypes)
    {
      case UiTypes.dropDown:
        return HeaderDropDownField(RequestSender(uiIndex,data.dataIndex,data.uiTypes,data.admRequestManagerDt!.title,'${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra3)} ${data.admRequestManagerDt!.title}',data.data,data.dependent,data.isEnable,data.admRequestManagerDt,selectedIndex: data.selectedIndex),requestCallBack,key: Key('DropDownnn$uiIndex'));
      case UiTypes.textBox:
        return RequestTextField(RequestSender(uiIndex,data.dataIndex,data.uiTypes,data.admRequestManagerDt!.title,'${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra4)} ${data.admRequestManagerDt!.title}',data.data,data.dependent,data.isEnable,data.admRequestManagerDt),requestCallBack,scopeNode!,key: Key('textfieldd$uiIndex'));
      case UiTypes.checkBox:
      // TODO: Handle this case.
        return RequestCheckBoxWidget(RequestSender(uiIndex,data.dataIndex,data.uiTypes,data.admRequestManagerDt!.title,'${data.admRequestManagerDt!.title}',data.data,data.dependent,data.isEnable,data.admRequestManagerDt,selectedIndex: data.selectedIndex),requestCallBack,key: Key('CheckBoxxxx$uiIndex'));
      case UiTypes.datePicker:
        return CalenderTimeWidget(RequestSender(uiIndex,data.dataIndex,data.uiTypes,data.admRequestManagerDt!.title,'${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra3)} ${data.admRequestManagerDt!.title}',data.data,data.dependent,data.isEnable,data.admRequestManagerDt),requestCallBack,key: Key('datepickerr$uiIndex'));
      case UiTypes.multipleDropDown:
      // TODO: Handle this case.
        return MultiDropDownField(RequestSender(uiIndex,data.dataIndex,data.uiTypes,data.admRequestManagerDt!.title,'${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra3)} ${data.admRequestManagerDt!.title}',data.data,data.dependent,data.isEnable,data.admRequestManagerDt,selectedIndex: data.selectedIndex),requestCallBack,key: Key('MulDropDownnn$uiIndex'));
      case UiTypes.unKnown:
      // TODO: Handle this case.
        return Container();
      default:
        return Container();
    }
  }

  Future<void> requestCallBack(RequestCallBack requestCallBack)
  async {
    GetRequestFormListener getRequestFormListener = Provider.of<GetRequestFormListener>(context,listen: false);
    switch(requestCallBack.uiTypes)
    {
      case UiTypes.dropDown:
      // PrintLogs.print('now comeee ${requestCallBack.response?.name} | ${requestCallBack.dataIndex} | ${requestCallBack.selectedIndex} | ${requestCallBack.uiIndex}');
        await getRequestFormListener.updateSelectedIndex(requestCallBack);
        getRequestFormListener.updateDependents(CallNotify.notify,context);
        // getRequestFormListener.updateDependent(requestCallBack);
        break;
      case UiTypes.textBox:
        PrintLogs.printLogs('now comeeeas ${requestCallBack.response?.name}');
        getRequestFormListener.updateTextBox(requestCallBack);
        break;
      case UiTypes.multipleDropDown:
        break;
      case UiTypes.datePicker:
        getRequestFormListener.updateDateTimeBox(requestCallBack);
        break;
      case UiTypes.checkBox:
        getRequestFormListener.updateCheckBox(requestCallBack);
        break;
      default:
        break;
    }
  }
}

