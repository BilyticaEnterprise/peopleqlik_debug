import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/Version1/models/RequestsModel/get_request_separation_form_model.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class RequestSeparationFormListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  LoginResultSet? loginResultSet;
  GetSeparationEmployeeResultSet? getSeparationEmployeeResultSet;
  int randomNumber = 0;
  Future? start(BuildContext context)
  async {
    apiStatus = ApiStatus.started;
    notifyListeners();
    loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getSeparationEmployeeFormApiCall(context,'?EmployeeCode=${employeeInfoMapper.employeeCode}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      getSeparationEmployeeResultSet = apiResponse.data!.resultSet;
      randomNumber = (Random().nextInt(10)+1);
      apiStatus = ApiStatus.done;
      notifyListeners();

    }
    else
    {
      apiStatus = apiResponse.apiStatus!;
      getSeparationEmployeeResultSet = null;

      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }

}
class RequestSeparationData
{
  String? title;
  String? hint;
  dynamic data;
  int? index;
  bool? isEnable,isRequired;
  Function(RequestSeparationCallBack data)? callBack;
  RequestSeparationData({required this.index,required this.title,required this.data,required this.isEnable,required this.isRequired,required this.callBack,this.hint});
}
class RequestSeparationCallBack
{
  dynamic data;
  int? index;
  RequestSeparationCallBack({this.index,this.data});
}
