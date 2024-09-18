import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleEncashment/subModules/encashmentFormModule/presentation/listener/request_balance_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleEncashment/subModules/encashmentFormModule/presentation/listener/request_encashment_form_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/request_attachment_collector.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/time_off_add_edit_attachments_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/UploadFileListener/upload_file_listener.dart';
import 'package:peopleqlik_debug/Version1/models/RequestsModel/get_request_form_data.dart';
import 'package:peopleqlik_debug/Version1/models/RequestsModel/EncashmentsModels/get_request_encashment_balance_model.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleEncashment/subModules/encashmentFormModule/utils/special_dropdown_widgets.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleEncashment/subModules/encashmentFormModule/utils/special_textfield_widget.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/SearchEmployeePanelPages/panel_header.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TimeOffPage/TimeOffSubPages/AddEditTimeOffPages/attachmentfiles.dart';
import '../../../../../../../../../utils/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/hide_keyboard.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../../../../Version1/models/RequestsModel/request_data_taker.dart';
import '../../../../../../../../../utils/Appbars/generic_app_bar.dart';
import '../../../../../../../../../utils/Reuse_LogicalWidgets/current_employee_name_note.dart';
import '../../../../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../../../../../Version1/views/BottomBarPages/GlobalEmployeeSearchUi/call_employee_search_ui.dart';


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
          ChangeNotifierProvider<RequestEncashmentFormListener>(create: (_) => RequestEncashmentFormListener()),
          ChangeNotifierProvider<RequestEcashmentBalanceListener>(create: (_) => RequestEcashmentBalanceListener()),
          ChangeNotifierProvider<EncashmentTypeList>(create: (_) => EncashmentTypeList())
        ],
        child: GestureDetector(
          onTap: (){HideShowKeyboard.hide(context);},
          child:
          GetPageStarterScaffoldStateLess(
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
                            Provider.of<RequestEcashmentBalanceListener>(context,listen: false).resetBalance();
                            Provider.of<RequestEncashmentFormListener>(context,listen: false).start(context);
                          }
                      );
                    },
                    removeEmployeeTap: () async {
                      await employeeData.resetEmployee();
                      Provider.of<RequestEcashmentBalanceListener>(context,listen: false).resetBalance();
                      Provider.of<RequestEncashmentFormListener>(context,listen: false).start(context);
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
                      Provider.of<RequestEcashmentBalanceListener>(context,listen: false).resetBalance();
                      Provider.of<RequestEncashmentFormListener>(context,listen: false).start(context);
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
      Provider.of<RequestEncashmentFormListener>(context,listen: false).start(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<RequestEncashmentFormListener>(
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
          Consumer<RequestEcashmentBalanceListener>(
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
      Provider.of<RequestEcashmentBalanceListener>(buildContext,listen: false).apiStatus = ApiStatus.nothing;
      Provider.of<RequestEncashmentFormListener>(buildContext,listen: false).startApi(buildContext, requestEnCashmentCallBack.data);
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
    Provider.of<RequestEncashmentFormListener>(context,listen: false).updateFileData(file);
  }
  void callback(RequestEnCashmentCallBack requestEnCashmentCallBack)
  {
    if(requestEnCashmentCallBack.index == 4)
    {
      if(requestEnCashmentCallBack.data == 0)
        {
          Provider.of<RequestEncashmentFormListener>(context,listen: false).saveSpecialRequestFormMapper?.typeID = '1';
        }
      else
        {
          Provider.of<RequestEncashmentFormListener>(context,listen: false).saveSpecialRequestFormMapper?.typeID = '2';
          Provider.of<RequestEncashmentFormListener>(context,listen: false).saveSpecialRequestFormMapper?.encashmentUnit = null;

        }
      Provider.of<EncashmentTypeList>(context,listen: false).indexId(requestEnCashmentCallBack.data);
    }
    if(requestEnCashmentCallBack.index == 5)
      {
        Provider.of<RequestEncashmentFormListener>(context,listen: false).saveSpecialRequestFormMapper?.encashmentUnit = requestEnCashmentCallBack.data;
      }
    if(requestEnCashmentCallBack.index == 6)
    {
      Provider.of<RequestEncashmentFormListener>(context,listen: false).saveSpecialRequestFormMapper?.paymentTypeID = requestEnCashmentCallBack.data.typeID.toString();
    }
  }
  void confirmPressed()
  {
    Provider.of<RequestEncashmentFormListener>(context,listen: false).fillData(context);
  }
}
