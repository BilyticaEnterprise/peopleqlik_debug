import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/loader_class.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/post_separation_calendar_api.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_detail_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/loader.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import '../../../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../ApiCalls/ApiGlobalModel/api_global_model.dart';

class GetRequestSeparationCalendarListener extends GetChangeNotifier with GetLoader
{
  RequestSeparationDetailData? requestSeparationDetailData;


  Future? start(BuildContext context)
  async {
   // PostSeparationCalendarRequestData? postSeparationCalendarRequestData = await PostSeparationCalendarRequestApiCall().callApi(context,requestSeparationDetailData?.id,requestSeparationDetailData?.lastWorkingDate,requestSeparationDetailData?.remarks);

    initLoader();
    ApiResponse? apiResponse = await GetApisUrlCaller().getSeparationCalendar(context,'?ID=${requestSeparationDetailData?.id}&LastWorkingDate=${requestSeparationDetailData?.lastWorkingDate}&NewRemarks=${requestSeparationDetailData?.remarks}');
    await closeLoader();
    Future.delayed(const Duration(milliseconds: 100),(){
      if(apiResponse.apiStatus == ApiStatus.done)
      {
        Navigator.pop(context,true);
      }
      else
      {
        ShowErrorMessage.show(apiResponse);
      }
    });
    // if(postSeparationCalendarRequestData!=null&&postSeparationCalendarRequestData.postRequestJson!=null&&postSeparationCalendarRequestData.postRequestJson?.isSuccess==true)
    // {
    //   loadingStream.add(true);
    //   Navigator.pop(context,true);
    // }
    // else
    // {
    //   loadingStream.add(true);
    //   if(postSeparationCalendarRequestData!=null&&postSeparationCalendarRequestData.postRequestJson!=null&&postSeparationCalendarRequestData.postRequestJson?.errorMessage!=null) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,postSeparationCalendarRequestData.postRequestJson!.errorMessage!,color: MyColor.colorRed));
    //   }
    //   else
    //   {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,postSeparationCalendarRequestData!.message!,color: MyColor.colorRed));
    //   }
    //   notifyListeners();
    //   if(postSeparationCalendarRequestData.code == GetVariable.fourZeroOne)
    //   {
    //     Navigator.pushNamedAndRemoveUntil(context, CurrentPage.CompanyPage, ModalRoute.withName(CurrentPage.LoginPage));
    //   }
    // }

  }

  void updateLastDate(data) {
    requestSeparationDetailData?.lastWorkingDate = data;
  }

  void updateRemarks(String remarks) {
    requestSeparationDetailData?.remarks = remarks;
  }
  void submit(BuildContext context)
  {
    if(requestSeparationDetailData?.lastWorkingDate!=null
        &&requestSeparationDetailData?.remarks!=null
        &&requestSeparationDetailData!.remarks.isNotEmpty
        &&requestSeparationDetailData!.remarks!.length>=15
    )
      {
        start(context);
      }
    else
      {
        if(requestSeparationDetailData?.lastWorkingDate==null)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.separationLastWorkingDate)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationFieldEmpty)}');
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
        }
        else if(requestSeparationDetailData?.remarks==null)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.separationJustification)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationFieldEmpty)}');
         // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
        }
        else if(requestSeparationDetailData!.remarks!.replaceAll(' ', '').isEmpty)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.separationJustification)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationFieldEmpty)}');
         // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
        }
        else if(requestSeparationDetailData?.remarks!=null&&requestSeparationDetailData!.remarks!.length<15)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.separationJustification)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationFieldLength)} ${15}');
         // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
        }
      }
  }
}