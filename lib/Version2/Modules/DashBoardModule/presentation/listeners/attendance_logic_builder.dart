import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/attendance_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/attendance_types_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/sliding_up_panel.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/settings_pref.dart';
import 'package:peopleqlik_debug/utils/UserLocation/get_user_location.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/get_distance.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../utils/enums/attendance_type_enums.dart';

class AttendanceLogicBuilder extends GetChangeNotifier
{
  SliderWidgetEnum? sliderWidgetEnumIs;
  bool isUserLocationRequired=false;
  BuildContext? dashBoardContext;

  void start(BuildContext context)async
  {
    //PrintLogs.print('ayaaaa');
    if(await checkEitherGetLocation(context)==true)
    {
      CheckUserLocation checkUserLocation = Provider.of<CheckUserLocation>(context,listen: false);
      LocationEnum? locationEnum = await checkUserLocation.check(context);
      if(locationEnum==LocationEnum.success)
      {
        SlidingPanelData slidingPanelData = Provider.of<SlidingPanelData>(context,listen: false);
        slidingPanelData.currentPage = sliderWidgetEnumIs;
        slidingPanelData.notifyListener();
        await slidingPanelData.panelController?.open();
      }
      else if(locationEnum==LocationEnum.mockLocation)
      {
        checkUserLocation.mockLocationCaught(context);
      }
      else if(locationEnum==LocationEnum.permission)
      {
        checkUserLocation.failedPermission(context);
      }
      else if(locationEnum == LocationEnum.goToSettings)
      {
        checkUserLocation.goToSettings(context);
      }
      else
      {
       // PrintLogs.print('bhagoooo ggg');
      }
    }
    else{
      SlidingPanelData slidingPanelData = Provider.of<SlidingPanelData>(context,listen: false);
      slidingPanelData.currentPage = sliderWidgetEnumIs;
      slidingPanelData.notifyListener();
      await slidingPanelData.panelController?.open();
    }
  }
  Future<bool>? checkEitherGetLocation(BuildContext context) async
  {
    /// Checking User setting either user's location is required or not
    // PrintLogs.print('geofenceee ${Provider?.of<SettingsController>(context,listen: false).settingsResultSet?.employeeCompanyData?.empLocation?.enableGeoFence}');
    SettingsResultSet settingsResultSet = SettingsResultSet.fromJson(await jsonDecode(await SettingsPrefs().getSettingsPrefs()));
    if(settingsResultSet.locationInfo?.geoFence==true||settingsResultSet.locationInfo?.geoTagging==true)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  void onConfirmedClicked(BuildContext context) async
  {
    if(await checkPremises(context) == false)
      {
        await Provider.of<SlidingPanelData>(context,listen: false).panelController?.close();
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra6AttendanceLogicBuilder)}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra6AttendanceLogicBuilder)}',color: MyColor.colorRed));
      }
    else
      {
        int index = Provider.of<AttendanceTypesCollector>(context,listen: false).list.indexWhere((element) => element.selected==true);

        if(Provider.of<AttendanceTypesCollector>(context,listen: false).attendanceTypesModel!=null&&index!=-1)
        {
          // PrintLogs.print('andraya ${Provider.of<AttendanceTypesCollector>(context,listen: false).attendanceTypesModel!.attendanceTypesEnum}');
          if(Provider.of<AttendanceTypesCollector>(context,listen: false).attendanceTypesModel!.attendanceTypesEnum == AttendanceTypesEnum.simple)
          {
           // PrintLogs.print('daandraya');
            startCheckingInOut(context);
            Provider.of<SlidingPanelData>(context,listen: false).panelController?.close();
          }
          else if(Provider.of<AttendanceTypesCollector>(context,listen: false).attendanceTypesModel!.attendanceTypesEnum == AttendanceTypesEnum.qrCode)
          {
           // PrintLogs.print('qewandraya');
            //Navigator.pushNamed(Provider.of<CheckInOutModelStarter>(context,listen: false).dashBoardContext??context, CurrentPage.QrCodePage,);
          }
        }
        else{
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra5AttendanceLogicBuilder)}');
          // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra5AttendanceLogicBuilder)}',color: MyColor.colorRed));
        }
      }
  }
  Future<bool?> checkPremises(BuildContext context) async
  {
    CheckUserLocation checkUserLocation = Provider.of(context,listen: false);
    SettingsResultSet settingsResultSet = SettingsResultSet.fromJson(await jsonDecode(await SettingsPrefs().getSettingsPrefs()));
    if(settingsResultSet.locationInfo?.geoFence==true)
    {
      if(checkUserLocation.position?.latitude!=null&&checkUserLocation.position?.longitude!=null&&settingsResultSet.locationInfo?.latitude!=null&&settingsResultSet.locationInfo?.longitude!=null&&settingsResultSet.locationInfo?.radius!=null)
        {
          if(Distance.getDistance(checkUserLocation.position?.latitude, checkUserLocation.position?.longitude, double.parse(settingsResultSet.locationInfo?.latitude??'0.0'), double.parse(settingsResultSet.locationInfo?.longitude??'0.0'), DistanceIn.meters)!<=double.parse(settingsResultSet.locationInfo?.radius??'0.0'))
          {
            PrintLogs.printLogs('in premises');
            return true;
          }
          else
            {
              return false;
            }
        }
      else
        {
          return false;
        }
    }
    return true;
  }
  void startCheckingInOut(BuildContext context)
  {
    //PrintLogs.printLogs('voidstart');

    PostAttendanceListener postAttendanceListener = Provider.of<PostAttendanceListener>(context,listen: false);
    //PrintLogs.print('asadstart ${Provider?.of<AttendanceLogicBuilder>(context,listen: false).sliderWidgetEnumIs} ${postAttendanceListener.checkInOutBreakInStatus}');
    if(Provider.of<AttendanceLogicBuilder>(context,listen: false).sliderWidgetEnumIs==SliderWidgetEnum.checkInTypes
        &&postAttendanceListener.checkInOutBreakInStatus == CheckInOutBreakInStatus.checkIn
    )
    {
      //PrintLogs.printLogs('start');
      ///Ahsan said send 0 cz attendanceMode value is getting from backend
      Provider.of<PostAttendanceListener>(context,listen: false).makePostMapper(context, 0);

    }

    if(Provider.of<AttendanceLogicBuilder>(context,listen: false).sliderWidgetEnumIs==SliderWidgetEnum.checkInTypes
        &&postAttendanceListener.checkInOutBreakInStatus == CheckInOutBreakInStatus.checkOut
    )
    {
      //PrintLogs.printLogs('estart');
      ///Ahsan said send 0 cz attendanceMode value is getting from backend
      Provider.of<PostAttendanceListener>(context,listen: false).makePostMapper(context, 0);

    }
  }
}
enum CheckInOutBreakInStatus
{
  checkIn,checkOut,breakIn,breakOut,nothing
}
class CheckInOutId
{
  static const int checkIn = 1;
  static const int checkOut = 2;
}