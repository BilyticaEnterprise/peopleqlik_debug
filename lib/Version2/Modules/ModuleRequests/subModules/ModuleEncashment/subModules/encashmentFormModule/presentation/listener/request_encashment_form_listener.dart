import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleEncashment/subModules/encashmentFormModule/presentation/listener/request_balance_listener.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/time_off_add_edit_attachments_collector.dart';
import 'package:peopleqlik_debug/Version1/models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/Version1/models/RequestsModel/get_request_form_data.dart';
import 'package:peopleqlik_debug/Version1/models/RequestsModel/EncashmentsModels/post_request_encashment_form_mapper.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class RequestEncashmentFormListener extends GetChangeNotifier with GetLoader
{
  ApiStatus apiStatus = ApiStatus.nothing;
  //LoginResultSet? loginResultSet;
  List<GetFileType>? getFiles;
  SaveEncashmentRequestFormMapper? saveSpecialRequestFormMapper;
  SpecialRequestResultSet? specialRequestResultSet;
  Future? start(BuildContext context)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getEncashmentRequestFormApiCall(context,'?CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      specialRequestResultSet = apiResponse.data!.resultSet;
      apiStatus = ApiStatus.done;
      notifyListeners();

    }
    else
    {
      apiStatus = apiResponse.apiStatus!;
      specialRequestResultSet = null;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }
  void startApi(BuildContext context,EmployeeLeaveType employeeLeaveType)
  {
    /// initializing this mapper because all the selected data will gonna be saved in this mapper and also if user
    /// changes its LeaveType then auto it will be re initialized
    saveSpecialRequestFormMapper = SaveEncashmentRequestFormMapper();
    saveSpecialRequestFormMapper?.leaveType = employeeLeaveType.typeName;
    saveSpecialRequestFormMapper?.leaveTypeCode = employeeLeaveType.typeCode;
    saveSpecialRequestFormMapper?.calendarCode = employeeLeaveType.calendarCode;

    /// Calling User leave balance api
    Provider.of<RequestEcashmentBalanceListener>(context,listen: false).start(context, employeeLeaveType.calendarCode!, employeeLeaveType.typeCode!);
  }

  void updateFileData(List<GetFileType> file) {
    getFiles = file;
  }

  void fillData(BuildContext context) async{
    if(saveSpecialRequestFormMapper!=null&&
        saveSpecialRequestFormMapper?.leaveType!=null&&
        saveSpecialRequestFormMapper?.paymentTypeID!=null&&
        saveSpecialRequestFormMapper?.typeID!=null
    )
      {
        RequestEcashmentBalanceListener specialBalanceListener = Provider.of<RequestEcashmentBalanceListener>(context,listen: false);
        saveSpecialRequestFormMapper?.balanceUnit = specialBalanceListener.specialRequestBalanceResultSet?[0].balance.toString();
        saveSpecialRequestFormMapper?.maxEncashmentUnit = specialBalanceListener.specialRequestBalanceResultSet?[0].maxEncashmentUnit.toString();
        saveSpecialRequestFormMapper?.approvalStatusID = 1;
        /// Here we are check either user select Encashment Type FULLY or PARTIALLY if Fully then means we have to set
        /// total allowed balance which we get from SpecialBalance Api.....
        if(saveSpecialRequestFormMapper?.typeID == '1'&&specialBalanceListener.specialRequestBalanceResultSet?[0].balance>0)
          {
            saveSpecialRequestFormMapper?.encashmentUnit = specialBalanceListener.specialRequestBalanceResultSet?[0].balance.toString();
          }
        /// but if user select Partially then user can select total
        /// allowed MaxEncashment and for that purpose user will write by himself and 'saveSpecialRequestFormMapper?.encashmentUnit'
        /// will be updated automatically as we are listening user inputs in our UI. That is why we are checking again that
        /// if 'saveSpecialRequestFormMapper?.encashmentUnit' is not null or empty then it means either user select
        /// Partially and we set Balance by ourselves but if user select Finally then user will give us his input and we will
        /// check that input.
        try{
          if(saveSpecialRequestFormMapper?.encashmentUnit!=null&&saveSpecialRequestFormMapper!.encashmentUnit!.isNotEmpty&&double.parse(saveSpecialRequestFormMapper!.encashmentUnit!)<=specialBalanceListener.specialRequestBalanceResultSet?[0].maxEncashmentUnit&&double.parse(saveSpecialRequestFormMapper!.encashmentUnit!)<=specialBalanceListener.specialRequestBalanceResultSet?[0].balance)
          {
            List<SaveEncashmentRequestFormMapper> list = List.empty(growable: true);
            var encoded = jsonEncode(saveSpecialRequestFormMapper?.toJson());

            LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
            dynamic companyCode = loginResultSet.headerInfo!.companyCode;
            dynamic employeeCode = loginResultSet.headerInfo!.employeeCode;

            /// When user want to check other employees timeOff then we will check either user has selected an employee
            EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();
            companyCode = employeeInfoMapper.companyCode;
            employeeCode = employeeInfoMapper.employeeCode;

            SaveEncashmentRequestFormMapper s1 = SaveEncashmentRequestFormMapper.fromJson(await jsonDecode(encoded));
            s1.cultureID = '1';
            s1.employeeCode = employeeCode;
            s1.companyCode = companyCode;
            if(getFiles!=null&&getFiles!.length>1)
              {
                List<LaLeaveEncashmentRequestDt> l1 = List.empty(growable: true);
                for(int x=1;x<getFiles!.length;x++)
                  {
                    LaLeaveEncashmentRequestDt laLeaveEncashmentRequestDt = LaLeaveEncashmentRequestDt();
                    laLeaveEncashmentRequestDt.cultureID = '1';
                    laLeaveEncashmentRequestDt.iD = x+1;
                    laLeaveEncashmentRequestDt.fileName = getFiles?[x].uploadedResultSet?.docName;
                    laLeaveEncashmentRequestDt.fileSize = '10 Kb';
                    l1.add(laLeaveEncashmentRequestDt);
                  }
                s1.laLeaveEncashmentRequestDt = l1;
              }
            else
            {
              s1.laLeaveEncashmentRequestDt = List.empty(growable: true);
            }
            list.add(s1);

            // SaveEncashmentRequestFormMapper s2 = SaveEncashmentRequestFormMapper.fromJson(await jsonDecode(encoded));
            // s2.cultureID = '2';
            // s2.employeeCode = employeeCode;
            // s2.companyCode = companyCode;
            // if(getFiles!=null&&getFiles!.length>1)
            // {
            //   List<LaLeaveEncashmentRequestDt> l2 = List.empty(growable: true);
            //   for(int x=1;x<getFiles!.length;x++)
            //   {
            //     LaLeaveEncashmentRequestDt laLeaveEncashmentRequestDt = LaLeaveEncashmentRequestDt();
            //     laLeaveEncashmentRequestDt.cultureID = '2';
            //     laLeaveEncashmentRequestDt.iD = x+1;
            //     laLeaveEncashmentRequestDt.fileName = getFiles?[x].uploadedResultSet?.docName;
            //     laLeaveEncashmentRequestDt.fileSize = '10 Kb';
            //     l2.add(laLeaveEncashmentRequestDt);
            //   }
            //   s2.laLeaveEncashmentRequestDt = l2;
            // }
            // else
            //   {
            //     s2.laLeaveEncashmentRequestDt = List.empty(growable: true);
            //   }
            // list.add(s2);

            initLoader();
            ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().saveEncashmentRequestApi(context,list);
            await closeLoader();

            Future.delayed(const Duration(milliseconds: 100),(){
              if(apiResponse.apiStatus == ApiStatus.done)
              {
                if(apiResponse.data?.message!=null) {
                  SnackBarDesign.happySnack(apiResponse.data?.message??'');
                }
                Navigator.pop(context,true);
              }
              else
              {
                ShowErrorMessage.show(apiResponse);
              }
            });

          }
          else
          {
            if(saveSpecialRequestFormMapper!=null&&saveSpecialRequestFormMapper?.typeID!=null&&specialBalanceListener!=null&&specialBalanceListener.specialRequestBalanceResultSet?[0].balance==0&&saveSpecialRequestFormMapper?.typeID == '1')
              {
                SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError1)} ${specialBalanceListener.specialRequestBalanceResultSet?[0].balance} ${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError2)}');
                // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
              }
            else if(saveSpecialRequestFormMapper?.encashmentUnit!=null&&saveSpecialRequestFormMapper!.encashmentUnit!.isNotEmpty&&double.parse(saveSpecialRequestFormMapper!.encashmentUnit!)>specialBalanceListener.specialRequestBalanceResultSet?[0].maxEncashmentUnit)
              {
                SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError3)} ${specialBalanceListener.specialRequestBalanceResultSet?[0].maxEncashmentUnit} ${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError4)}');
               // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
              }
            else if(saveSpecialRequestFormMapper?.encashmentUnit!=null&&saveSpecialRequestFormMapper!.encashmentUnit!.isNotEmpty&&double.parse(saveSpecialRequestFormMapper!.encashmentUnit!)<=specialBalanceListener.specialRequestBalanceResultSet?[0].maxEncashmentUnit&&double.parse(saveSpecialRequestFormMapper!.encashmentUnit!)>=specialBalanceListener.specialRequestBalanceResultSet?[0].balance)
            {
              SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError3)} ${specialBalanceListener.specialRequestBalanceResultSet?[0].balance} ${CallLanguageKeyWords.get(context, LanguageCodes.BalanceUnit)}');
              //ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
            }
            else
              {
                SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError5)}');
               // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
              }
            //scaffold
          }
        }
        catch(e)
        {
          SnackBarDesign.errorSnack(e.toString());
          //ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,,color: MyColor.colorRed));
          //scaffold
        }
      }
    else
      {
        if(saveSpecialRequestFormMapper==null)
          {
            SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError6)}');
           // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
          }
        else if(saveSpecialRequestFormMapper?.leaveType==null)
          {
            SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError7)}');
        //    ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError7)}',color: MyColor.colorRed));
          }
        else if(saveSpecialRequestFormMapper?.typeID==null)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError8)}');
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError8)}',color: MyColor.colorRed));
        }
        else if(saveSpecialRequestFormMapper?.paymentTypeID==null)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError9)}');
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'${CallLanguageKeyWords.get(context, LanguageCodes.EncashmentError9)}',color: MyColor.colorRed));
        }
      }
  }
}
class EncashmentTypeList extends GetChangeNotifier
{
  List<String> typeList = List.empty(growable: true);
  int currentIndex = -1;
  List<String> fillLeave()
  {
    typeList.clear();
    typeList.add('Fully');
    typeList.add('Partially');
    return typeList;
  }
  void indexId(int index)
  {
    currentIndex = index;
    notifyListeners();
  }
}
class RequestEnCashmentData
{
  String? title;
  dynamic data;
  int? index;
  bool? isEnable,isRequired;
  Function(RequestEnCashmentCallBack data)? callBack;
  RequestEnCashmentData({this.index,this.title,this.data,this.isEnable,this.isRequired,this.callBack});
}
class RequestEnCashmentCallBack
{
  dynamic data;
  int? index;
  RequestEnCashmentCallBack({this.index,this.data});
}
