import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';

import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';

class SaveRequestFormListener with GetLoader
{

  Future<bool> start(BuildContext context,var map)
  async {

    PrintLogs.printLogs('resiaiusda ${jsonEncode(map)}');
    initLoader();
    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().postRequestApi(context,map);
    await closeLoader();
    Future.delayed(const Duration(milliseconds: 100));
      if(apiResponse.apiStatus == ApiStatus.done)
      {
        if(apiResponse.data?.message!=null) {
          SnackBarDesign.happySnack(apiResponse.data?.message??'');
        }
        return true;
      }
      else
      {
        ShowErrorMessage.show(apiResponse);

        return false;
      }


  }
}

