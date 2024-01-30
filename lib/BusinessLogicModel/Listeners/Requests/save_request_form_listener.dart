import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/loader_class.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/post_request_api.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/post_request_model.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/icons.dart';
import 'package:peopleqlik_debug/src/loader.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';

import '../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../ApiCalls/ApiCallers/show_error.dart';
import '../../ApiCalls/ApiGlobalModel/api_global_model.dart';

class SaveRequestFormListener with GetLoader
{

  Future? start(BuildContext context,var map)
  async {

    initLoader();
    ApiResponse? apiResponse = await GetApisUrlCaller().postRequestApi(context,map);
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

