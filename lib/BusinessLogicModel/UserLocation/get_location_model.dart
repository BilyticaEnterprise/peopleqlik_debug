

import 'package:detect_fake_location/detect_fake_location.dart';
import 'package:location/location.dart';

class GetLocationCurrent
{
  Future<IsMockLocation?> locationIs() async
  {
    try{
      LocationData data = await Location().getLocation();
      // Position? data = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,forceAndroidLocationManager: true);
      // PrintLogs.printLogs('1stSkipped Checking fake Location hy bhai ${position.latitude} ${position.longitude}');

      bool isFakeLocation = await DetectFakeLocation().detectFakeLocation();
      if(isFakeLocation)
      {
        // PrintLogs.printLogs('fake Location hy bhai');
        return IsMockLocation(null, true);
      }

      // PrintLogs.printLogs('2ndSkipped Checking fake Location hy bhai ${data.latitude} ${data.longitude}');
      // PrintLogs.printLogs('fakeee ${data.isMock}');
      return IsMockLocation(data.isMock==true?null:data, data.isMock!=null?data.isMock!:false,);
      // return IsMockLocation(data, false,);

    } catch(e){
      return null;
    }
  }
}

class IsMockLocation
{
  LocationData? position;
  bool isMock;
  IsMockLocation(this.position,this.isMock);
}
