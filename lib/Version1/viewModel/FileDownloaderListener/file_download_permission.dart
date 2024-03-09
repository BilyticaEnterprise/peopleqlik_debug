import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckFilePermission
{
  Future<bool> askPermission()
  async {
    int givenPermission=0;

    List<Permission> permission = [Permission.storage];
    for(var data in permission)
    {
      if(await data.status.isGranted==true)
      {
        givenPermission++;
      }
    }
     PrintLogs.printLogs(givenPermission);
    if(givenPermission!=1)
    {
      PermissionStatus status1 = await Permission.storage.request();
      givenPermission=0;
      if(status1==PermissionStatus.granted)
      {
          PrintLogs.printLogs('grant ');
        givenPermission++;
      }
      else
      {
        PrintLogs.printLogs('notgrant');
      }
      // checkStatus.forEach((key, value) {
      //
      // });
      // PrintLogs.print('okaynowaskeddddd ${deniedPermission}');

      if(givenPermission==1) {
        // PrintLogs.print('iffnow ${deniedPermission}');
        return true;
      } else {
        //PrintLogs.print('elssssokaynowaskeddddd ${deniedPermission}');
        return false;
      }
    }
    else {

      return true;
    }
  }
}
