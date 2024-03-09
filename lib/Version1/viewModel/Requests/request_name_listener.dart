import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/Version1/Models/RequestsModel/get_request_name_model.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:provider/provider.dart';

import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';

class GetRequestNameListener extends GetChangeNotifier
{
  List<RequestNamesResultSet>? requestNamesResultSet;
  ApiStatus apiStatus = ApiStatus.nothing;

  Future? start(BuildContext context)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getRequestNameList(context);
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

