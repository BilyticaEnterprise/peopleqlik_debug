import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';

import 'package:peopleqlik_debug/Version1/models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/Version1/models/RequestsModel/get_request_separation_form_model.dart';
import 'package:peopleqlik_debug/Version1/models/RequestsModel/post_separation_form_mapper.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import '../../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class RequestSeparationSaveFormListener extends GetChangeNotifier with GetLoader
{
  //Query? query;
  int? totalDays;
  bool enableLastWorkingDate = false;
  String? name,jobTitle;
  dynamic employeeCode;
  SaveSeparationMapper? saveSeparationMapper;
  RequestSeparationSaveFormListener()
  {
    saveSeparationMapper = SaveSeparationMapper();
  }
  void selectedEmployee(double totalDays,bool isMandatoryToServerNoticePeriod,BuildContext context) async
  {
    this.totalDays = null;
    enableLastWorkingDate = false;
    saveSeparationMapper = null;
    saveSeparationMapper = SaveSeparationMapper();
    // LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    // dynamic companyCode = loginResultSet.headerInfo!.companyCode;
    // employeeCode = loginResultSet.headerInfo!.employeeCode;
    // name = loginResultSet.headerInfo!.employeeName;
    // jobTitle = loginResultSet.myProfile?.jobTitle??'Unknown';

    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    dynamic companyCode = employeeInfoMapper.companyCode;
    employeeCode = employeeInfoMapper.employeeCode;
    name = employeeInfoMapper.name;
    jobTitle = employeeInfoMapper.jobTitle??'Unknown';

    PrintLogs.printLogs('employeeCodeeee $employeeCode');
  //this.query = query;
    this.totalDays = totalDays.toInt();
    enableLastWorkingDate = isMandatoryToServerNoticePeriod;
    saveSeparationMapper?.jobCode = null; /// sending null jan booj kr reason hy
    saveSeparationMapper?.employeeCode = employeeCode;
    saveSeparationMapper?.companyCode = companyCode;
    saveSeparationMapper?.approvalStatusID = 1;
    notifyListeners();
  }

  void selectedEffectiveDate(data) {
    saveSeparationMapper?.effectiveFrom = data;
    saveSeparationMapper?.lastWorkingDate = GetDateFormats().getDateSeparation(data!,daysTotalToAdd: totalDays);
    notifyListeners();
  }

  void remarksData(text) {
    saveSeparationMapper?.remarks = text;
  }

  void submit(BuildContext context) async{
    if(saveSeparationMapper?.employeeCode!=null
    &&saveSeparationMapper?.effectiveFrom!=null
    &&saveSeparationMapper?.lastWorkingDate!=null
    &&saveSeparationMapper?.remarks!=null
    &&saveSeparationMapper!.remarks!.replaceAll(' ', '').isNotEmpty
        &&saveSeparationMapper!.remarks!.length>=15
    )
      {

        LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
        saveSeparationMapper?.createdBy = loginResultSet.headerInfo?.userID.toString();
        saveSeparationMapper?.modifiedBy = loginResultSet.headerInfo?.userID.toString();
        // saveSeparationMapper?.createdBy = '381';
        // saveSeparationMapper?.modifiedBy = '381';
        var encoded = jsonEncode(saveSeparationMapper?.toJson());
        List list = [];
        SaveSeparationMapper s1 = SaveSeparationMapper.fromJson(await jsonDecode(encoded));
        s1.cultureID='1';
        // SaveSeparationMapper s2 = SaveSeparationMapper.fromJson(await jsonDecode(encoded));  /// Ahsan said
        // s2.cultureID='2';
        list.add(s1.toJson());
        //list.add(s2.toJson());

        initLoader();
        ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().saveSeparationRequestApi(context,list);
        await closeLoader();

        Future.delayed(const Duration(milliseconds: 200),(){
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

        //     print('jaskdf ${jsonEncode(saveSeparationMapper?.toJson())}');
    }
    else
      {
        if(saveSeparationMapper?.employeeCode==null)
          {
            SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.separationEmployee)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationFieldEmpty)}');
           // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
          }
        else if(saveSeparationMapper?.effectiveFrom==null)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.separationEffectiveDate)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationFieldEmpty)}');
         // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
        }
        else if(saveSeparationMapper?.lastWorkingDate==null)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.separationLastWorkingDate)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationFieldEmpty)}');
         // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
        }
        else if(saveSeparationMapper?.remarks==null)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.separationJustification)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationFieldEmpty)}');
         // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
        }
        else if(saveSeparationMapper!.remarks!.replaceAll(' ', '').isEmpty)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.separationJustification)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationFieldEmpty)}');
         // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
        }
        else if(saveSeparationMapper?.remarks!=null&&saveSeparationMapper!.remarks!.length<15)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.separationJustification)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationFieldLength)} ${15}');
         // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
        }
      }
  }
}