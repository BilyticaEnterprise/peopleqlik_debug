import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:peopleqlik_debug/Version1/viewModel/sliding_up_panel.dart';
import 'package:peopleqlik_debug/utils/UserLocation/get_location_model.dart';

import 'package:peopleqlik_debug/utils/UserLocation/permissions.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader.dart';
import 'package:peopleqlik_debug/utils/pop_ups.dart';
import 'package:provider/provider.dart';

class CheckUserLocation
{
  LocationData? position;
  LocationEnum locationEnum = LocationEnum.nothing;
  bool checkAppBackground = false;
  Future<LocationEnum?> check(BuildContext context)
  async {
    if(await Location().serviceEnabled()==false)
    {
      locationEnum = LocationEnum.goToSettings;
      return locationEnum;
    }
    else {

      if(await CheckPermissionIos10().askPermission() == true)
      {
        StreamController<bool> loadingStream = StreamController.broadcast();
        ShowLoaderPopUp.showExtra(context,loadingStream);

        IsMockLocation? isMockLocation = await GetLocationCurrent().locationIs();
        if (isMockLocation!=null&&isMockLocation.isMock==false&&isMockLocation.position!=null) {
          await Future.delayed(const Duration(milliseconds: 100),);
          loadingStream.add(true);
          position = isMockLocation.position;
          locationEnum = LocationEnum.success;
          return locationEnum;

        }
        else if(isMockLocation!=null&&isMockLocation.isMock==true)
        {
          loadingStream.add(true);
          locationEnum = LocationEnum.mockLocation;
          return locationEnum;
        }
        else
        {
         // PrintLogs.print('else falseee');
          loadingStream.add(true);
          locationEnum = LocationEnum.failed;
          return locationEnum;
        }

      }
      else
      {
       // PrintLogs.print('fooooalseee');
        locationEnum = LocationEnum.permission;
        return locationEnum;
      }
    }
  }
  void goToSettings(BuildContext context)
  {
    Future.delayed(const Duration(milliseconds: 100),() async {
      SlidingPanelData slidingPanelData = Provider?.of<SlidingPanelData>(context,listen: false);
      slidingPanelData.currentPage = SliderWidgetEnum.permission;
      slidingPanelData.notifyListener();
      await slidingPanelData.panelController?.open();
    });

  }

  Future<void> failedPermission(BuildContext context)
  async {
    Future.delayed(const Duration(milliseconds: 100),() async {
      SlidingPanelData slidingPanelData = Provider?.of<SlidingPanelData>(context,listen: false);
      slidingPanelData.currentPage = SliderWidgetEnum.permission;
      slidingPanelData.notifyListener();
      await slidingPanelData.panelController?.open();
    });
  }

  void mockLocationCaught(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100),() async {
      SlidingPanelData slidingPanelData = Provider.of<SlidingPanelData>(context,listen: false);
      slidingPanelData.currentPage = SliderWidgetEnum.mockLocation;
      slidingPanelData.notifyListener();
      await slidingPanelData.panelController?.open();
    });
  }

}
enum LocationEnum
{
  nothing,start,success,failed,goToSettings,permission,mockLocation
}