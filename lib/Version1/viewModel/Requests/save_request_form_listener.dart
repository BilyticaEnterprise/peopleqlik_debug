import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/Version1/ApiCalls/post_request_api.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/Models/RequestsModel/post_request_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';

import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';

class SaveRequestFormListener with GetLoader
{

  Future? start(BuildContext context,var map)
  async {

    initLoader();
    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().postRequestApi(context,map);
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
}

