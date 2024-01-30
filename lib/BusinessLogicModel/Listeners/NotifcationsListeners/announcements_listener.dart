import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/show_error.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/Notifications/announcement_list_model.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';


class GetAnnouncementModelListener extends GetChangeNotifier
{
  GetAnnouncementListResultSet? notificationDataList;
  ApiStatus apiStatus = ApiStatus.nothing;

  Future? start(BuildContext context, ApiStatus status)
  async {

    apiStatus = status;

    notifyListeners();

    ApiResponse apiResponse = await GetApisUrlCaller().getAnnouncementListApiCall(context);
    if(apiResponse.apiStatus==ApiStatus.done)
    {
      apiStatus = ApiStatus.done;
      notificationDataList = apiResponse.data!.resultSet;

      notifyListeners();
    }
    else
    {
      apiStatus = apiResponse.apiStatus??ApiStatus.error;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }

  }
}

