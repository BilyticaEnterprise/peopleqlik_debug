import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/request_enums.dart';

import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestLeaveEncashmentListeners/request_balance_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_attachment_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestLeaveEncashmentListeners/request_encashment_form_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/time_off_add_edit_attachments_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/UploadFileListener/upload_file_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_form_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_encashment_balance_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/EncashmentRequestLeaveEncashment/EncashmentFormWidgets/special_dropdown_widgets.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/EncashmentRequestLeaveEncashment/EncashmentFormWidgets/special_textfield_widget.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/SearchEmployeePanelPages/panel_header.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/TimeOffPage/TimeOffSubPages/AddEditTimeOffPages/attachmentfiles.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/form_submit_appbar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Buttons/buttons.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/hide_keyboard.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import '../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestLeaveEncashmentListeners/request_encashment_list_listener.dart';
import '../../../../Reuse_LogicalWidgets/current_employee_name_note.dart';
import '../../../../Reuse_Widgets/Appbars/generic_app_bar.dart';
import '../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../GlobalEmployeeSearchUi/call_employee_search_ui.dart';


class RequestEncashmentFormPage extends StatelessWidget {
  RequestEncashmentFormPage({Key? key}) : super(key: key);
  RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)!.settings.arguments as RequestDataTaker;
    Provider.of<GlobalSelectedEmployeeController>(context,listen: false).saveTempEmployee();
    return WillPopScope(
      onWillPop: ()async{
        Provider.of<GlobalSelectedEmployeeController>(context,listen: false).specialPop(context);
        return false;
      },

      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<TimeOffAddEditAttachments>(create: (_) => TimeOffAddEditAttachments()),
          ChangeNotifierProvider<RequestAttachments>(create: (_) => RequestAttachments()),
          ChangeNotifierProvider<RequestSpecialFormListener>(create: (_) => RequestSpecialFormListener()),
          ChangeNotifierProvider<RequestSpecialBalanceListener>(create: (_) => RequestSpecialBalanceListener()),
          ChangeNotifierProvider<EncashmentTypeList>(create: (_) => EncashmentTypeList())
        ],
        child: GestureDetector(
          onTap: (){HideShowKeyboard.hide(context);},
          child:
          GetPageStarterScaffold(
            body: BodyNow(requestDataTaker),
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
                            Provider.of<RequestSpecialBalanceListener>(context,listen: false).resetBalance();
                            Provider.of<RequestSpecialFormListener>(context,listen: false).start(context);
                          }
                      );
                    },
                    removeEmployeeTap: () async {
                      await employeeData.resetEmployee();
                      Provider.of<RequestSpecialBalanceListener>(context,listen: false).resetBalance();
                      Provider.of<RequestSpecialFormListener>(context,listen: false).start(context);
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
                      Provider.of<RequestSpecialBalanceListener>(context,listen: false).resetBalance();
                      Provider.of<RequestSpecialFormListener>(context,listen: false).start(context);
                    }
                );
              }
          ),
        ),
      ),
    );
  }
}
class BodyNow extends StatefulWidget {
  final RequestDataTaker? requestDataTaker;
  const BodyNow(this.requestDataTaker, {Key? key}) : super(key: key);

  @override
  _BodyNowState createState() => _BodyNowState();
}

class _BodyNowState extends State<BodyNow> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //RequestDataTaker? requestDataTaker = RequestDataTaker(widget.requestDataTaker!.id, widget.requestDataTaker!.title,requestsEnum: RequestsEnum.encashmentForm);
      //Provider.of<EmployeeSearchController>(context,listen: false).requestDataTaker = requestDataTaker;
      Provider.of<RequestSpecialFormListener>(context,listen: false).start(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<RequestSpecialFormListener>(
        builder: (context, data, child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return BodyData(data.specialRequestResultSet);
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

class BodyData extends StatelessWidget {
  final SpecialRequestResultSet? specialRequestResultSet;
  late BuildContext buildContext;
  BodyData(this.specialRequestResultSet, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CurrentEmployeeNoteWidget(),
          SizedBox(height: ScreenSize(context).heightOnly(2),),
          SpecialRequestDropDownField(RequestEnCashmentData(index: 0,title: CallLanguageKeyWords.get(context, LanguageCodes.LeaveType)??'',data: specialRequestResultSet?.employeeLeaveType,isEnable: true,isRequired: true,callBack: callback),key: const Key('0drop'),),
          Consumer<RequestSpecialBalanceListener>(
              builder: (context,dataBalance,child) {
                if(dataBalance.apiStatus == ApiStatus.done)
                {
                  return BalanceBody(dataBalance.specialRequestBalanceResultSet,specialRequestResultSet);
                }
                else if(dataBalance.apiStatus == ApiStatus.empty)
                {
                  return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
                }
                else if(dataBalance.apiStatus == ApiStatus.error)
                {
                  return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
                }
                else if(dataBalance.apiStatus == ApiStatus.nothing)
                {
                  return Container();
                }
                else
                {
                  return Container(
                      margin: EdgeInsets.only(top: ScreenSize(context).heightOnly( 5)),
                      child: const CircularIndicatorCustomized()
                  );
                }
              }
          ),
        ],
      ),
    );
  }
  void callback(RequestEnCashmentCallBack requestEnCashmentCallBack)
  {
    if(requestEnCashmentCallBack.index == 0)
    {
      Provider.of<RequestSpecialBalanceListener>(buildContext,listen: false).apiStatus = ApiStatus.nothing;
      Provider.of<RequestSpecialFormListener>(buildContext,listen: false).startApi(buildContext, requestEnCashmentCallBack.data);
    }
  }

}

class BalanceBody extends StatefulWidget {
  final List<SpecialBalanceResultSet>? specialRequestBalanceResultSet;
  final SpecialRequestResultSet? specialRequestResultSet;
  const BalanceBody(this.specialRequestBalanceResultSet, this.specialRequestResultSet, {Key? key}) : super(key: key);

  @override
  _BalanceBodyState createState() => _BalanceBodyState();
}

class _BalanceBodyState extends State<BalanceBody> {
  FocusScopeNode? focusScopeNode;
  @override
  void initState() {
    focusScopeNode = FocusScopeNode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        SpecialRequestTextField(RequestEnCashmentData(index: 1,title: CallLanguageKeyWords.get(context, LanguageCodes.RequestDateIs)??'',data: '${GetDateFormats().getFormatDate(DateTime.now())}',isEnable: false,isRequired: false,callBack: callback),focusScopeNode!,key: const Key('1text'),),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        SpecialRequestTextField(RequestEnCashmentData(index: 2,title: CallLanguageKeyWords.get(context, LanguageCodes.BalanceUnit)??'',data: '${widget.specialRequestBalanceResultSet?[0].balance}',isEnable: false,isRequired: false,callBack: callback),focusScopeNode!,key: const Key('2text'),),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        SpecialRequestTextField(RequestEnCashmentData(index: 3,title: CallLanguageKeyWords.get(context, LanguageCodes.MaxEncashmentUnit)??'',data: '${widget.specialRequestBalanceResultSet?[0].maxEncashmentUnit}',isEnable: false,isRequired: false,callBack: callback),focusScopeNode!,key: const Key('3text'),),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        SpecialRequestDropDownField(RequestEnCashmentData(index: 4,title: CallLanguageKeyWords.get(context, LanguageCodes.EncashmentType)??'',data: Provider.of<EncashmentTypeList>(context,listen: false).fillLeave(),isEnable: true,isRequired: true,callBack: callback),key: const Key('4drop'),),
        Consumer<EncashmentTypeList>(
            builder: (context,dataIs,child) {
              if(dataIs.currentIndex>=0)
                {
                  return Column(
                    children: [
                      SizedBox(height: ScreenSize(context).heightOnly( 2),),
                      SpecialRequestTextField(RequestEnCashmentData(index: 5,title: CallLanguageKeyWords.get(context, LanguageCodes.EncashmentUnit)??'',data: '${dataIs.currentIndex==0?widget.specialRequestBalanceResultSet![0].balance:''}',isEnable: dataIs.currentIndex==0?false:true,isRequired: true,callBack: callback),focusScopeNode!,key: Key('${dataIs.currentIndex}text'),),
                      SizedBox(height: ScreenSize(context).heightOnly( 2),),
                      SpecialRequestDropDownField(RequestEnCashmentData(index: 6,title: CallLanguageKeyWords.get(context, LanguageCodes.PaymentMethod)??'',data: widget.specialRequestResultSet?.paymentType,isEnable: true,isRequired: true,callBack: callback),key: const Key('6drop'),),
                    ],
                  );
                }
              else
                {
                  return Container();
                }
            }
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 3),),
        AttachmentFileWidget('${CallLanguageKeyWords.get(context, LanguageCodes.pequestsaddFormAttachment)}',picturesCallBack,FileTypeServer.requestSpecial,height: 24,horizontalMargin: 2,topMargin:6,bottomMargin: 8,key: const Key('attachmentsRequest'),),
        SizedBox(height: ScreenSize(context).heightOnly( 6),),
        ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsaddFormButton)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: confirmPressed,),
        SizedBox(height:ScreenSize(context).heightOnly(16),),

      ],
    );
  }
  void picturesCallBack(List<GetFileType> file)
  {
    Provider.of<RequestSpecialFormListener>(context,listen: false).updateFileData(file);
  }
  void callback(RequestEnCashmentCallBack requestEnCashmentCallBack)
  {
    if(requestEnCashmentCallBack.index == 4)
    {
      if(requestEnCashmentCallBack.data == 0)
        {
          Provider.of<RequestSpecialFormListener>(context,listen: false).saveSpecialRequestFormMapper?.typeID = '1';
        }
      else
        {
          Provider.of<RequestSpecialFormListener>(context,listen: false).saveSpecialRequestFormMapper?.typeID = '2';
          Provider.of<RequestSpecialFormListener>(context,listen: false).saveSpecialRequestFormMapper?.encashmentUnit = null;

        }
      Provider.of<EncashmentTypeList>(context,listen: false).indexId(requestEnCashmentCallBack.data);
    }
    if(requestEnCashmentCallBack.index == 5)
      {
        Provider.of<RequestSpecialFormListener>(context,listen: false).saveSpecialRequestFormMapper?.encashmentUnit = requestEnCashmentCallBack.data;
      }
    if(requestEnCashmentCallBack.index == 6)
    {
      Provider.of<RequestSpecialFormListener>(context,listen: false).saveSpecialRequestFormMapper?.paymentTypeID = requestEnCashmentCallBack.data.typeID.toString();
    }
  }
  void confirmPressed()
  {
    Provider.of<RequestSpecialFormListener>(context,listen: false).fillData(context);
  }
}
