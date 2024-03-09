import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermissionIos10
{
  Future<bool> askPermission()
  async {
    int givenPermission=0;
    List<Permission> permission = [Permission.locationWhenInUse,Permission.locationAlways,Permission.location];
    for(var data in permission)
      {
        if(await data.status.isGranted==true)
          {
            givenPermission++;
          }
      }
   // PrintLogs.print(givenPermission);
    if(givenPermission<1)
    {
      PermissionStatus status1 = await Permission.location.request();
      PermissionStatus status2 = await Permission.locationWhenInUse.request();
      PermissionStatus status3 = await Permission.locationAlways.request();

      List<PermissionStatus> checkStatus = List.empty(growable: true);
      checkStatus.add(status1);
      checkStatus.add(status2);
      checkStatus.add(status3);
      givenPermission=0;
      for (var value in checkStatus) {
        if(value==PermissionStatus.granted)
        {
          givenPermission++;
        }
        else
        {
          PrintLogs.printLogs('notgrant');
        }
      }

      if(givenPermission>=1) {
        return true;
      } else {
        return false;
      }
    }
    else {
      return true;
    }
  }
}
