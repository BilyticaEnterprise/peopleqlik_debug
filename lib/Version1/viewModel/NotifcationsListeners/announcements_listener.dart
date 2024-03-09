import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/Models/Notifications/announcement_list_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';


class GetAnnouncementModelListener extends GetChangeNotifier
{
  GetAnnouncementListResultSet? notificationDataList;
  ApiStatus apiStatus = ApiStatus.nothing;

  Future? start(BuildContext context, ApiStatus status)
  async {

    apiStatus = status;

    notifyListeners();

    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getAnnouncementListApiCall(context);
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

