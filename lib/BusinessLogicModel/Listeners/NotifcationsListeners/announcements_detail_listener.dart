import 'dart:async';
import 'dart:convert';

import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/show_error.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/Notifications/announcement_detail_model.dart';


class GetAnnouncementDetailListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  List<String>? pictures;
  List<String>? documents;
  GetAnnouncementDetailResultSet? getAnnouncementDetailResultSet;

  Future? start(BuildContext context,String id)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse? apiResponse = await GetApisUrlCaller().getAnnouncementDetailApiCall(context,'?AnnouncementCode=$id');
    if(apiResponse.apiStatus==ApiStatus.done)
    {
      getAnnouncementDetailResultSet = apiResponse.data!.resultSet;
      checkAnnouncementPictures();
      apiStatus = ApiStatus.done;
      notifyListeners();
    }
    // else if(getAnnouncementDetailData!=null&&getAnnouncementDetailData.getAnnouncementDetailJson!=null&&getAnnouncementDetailData.getAnnouncementDetailJson?.isSuccess==true&&getAnnouncementDetailData.getAnnouncementDetailJson?.resultSet==null)
    // {
    //   apiStatus = ApiStatus.empty;
    //   notifyListeners();
    // }
    // else if(getAnnouncementDetailData!=null&&getAnnouncementDetailData.getAnnouncementDetailJson!=null&&getAnnouncementDetailData.getAnnouncementDetailJson?.isSuccess==false)
    // {
    //   apiStatus = ApiStatus.error;
    //   notifyListeners();
    // }
    else
    {

      apiStatus = apiResponse.apiStatus??ApiStatus.error;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }
  void checkAnnouncementPictures()
  {
    if(getAnnouncementDetailResultSet?.admAnnouncementDocument!=null&&getAnnouncementDetailResultSet!.admAnnouncementDocument!.isNotEmpty)
      {
        pictures = List.empty(growable: true);
        documents = List.empty(growable: true);

        for(int x=0;x<getAnnouncementDetailResultSet!.admAnnouncementDocument!.length;x++)
        {
          var spl = getAnnouncementDetailResultSet!.admAnnouncementDocument?[x].fileName?.split('.');

          if(spl?[1] == 'png'||spl?[1] == 'jpg' || spl?[1] == 'jpeg')
            {
              pictures?.add(getAnnouncementDetailResultSet!.admAnnouncementDocument![x].fileName!);
            }
          else
            {
              documents?.add(getAnnouncementDetailResultSet!.admAnnouncementDocument![x].fileName!);
            }
        }
      }
  }
}

