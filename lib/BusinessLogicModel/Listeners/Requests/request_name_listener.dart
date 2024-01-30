import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/show_error.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_name_model.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:provider/provider.dart';

import '../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../ApiCalls/ApiGlobalModel/api_global_model.dart';

class GetRequestNameListener extends GetChangeNotifier
{
  List<RequestNamesResultSet>? requestNamesResultSet;
  ApiStatus apiStatus = ApiStatus.nothing;

  Future? start(BuildContext context)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse? apiResponse = await GetApisUrlCaller().getRequestNameList(context);
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      requestNamesResultSet = apiResponse.data!.resultSet;
      apiStatus = ApiStatus.done;
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      requestNamesResultSet = null;
      apiStatus = ApiStatus.empty;
      notifyListeners();
    }
    else
    {
      apiStatus = apiResponse.apiStatus!;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }

  }

  createUrl(BuildContext context, dynamic extraData) {
    String url = '${extraData.redirectUrl}${Uri.encodeComponent('${Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.headerInfo?.authtokenKey}\$\$${GetDateFormats().getSpecialDateInAhsanShakaFormat(extraData.now)}\$\$pms')}';
    PrintLogs.printLogs('urlasas $url');
    return url;
  }
}

