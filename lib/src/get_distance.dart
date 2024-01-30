import 'dart:math';

import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:vector_math/vector_math.dart';

class Distance
{
  static double? getDistance(double? userLat, double? userLong, double? companyLat, double? companyLong, DistanceIn unit)
  {
    if ((userLat == companyLat) && (userLong == companyLong)) {
      return 0;
    } else {
      if(userLat!=null&&userLong!=null&&companyLat!=null&&companyLong!=null)
        {
          double? theta = (userLong - companyLong);
          PrintLogs.printLogs('t1 $theta');
          double dist = ((sin(radians(userLat)) * sin(radians(companyLat))) + ((cos(radians(userLat)) * cos(radians(companyLat))) * cos(radians(theta))));
          PrintLogs.printLogs('t2 $dist');
          dist = acos(dist);
          PrintLogs.printLogs('t3 $dist');
          dist = degrees(dist);
          PrintLogs.printLogs('t4 $dist');
          dist = ((dist * 60) * 1.1515);
          PrintLogs.printLogs('t5 $dist');
          if (unit == DistanceIn.kilometer) {
            dist = (dist * 1.609344);
          }
          else if (unit == DistanceIn.meters) {
            dist = (dist * 1.609344)*1000;
          }else {
            if (unit == DistanceIn.nauticalMiles) {
              dist = (dist * 0.8684);
            }
          }
          return dist;
        }
      else{
        return null;
      }
    }
  }
}
enum DistanceIn
{
  kilometer,
  nauticalMiles,
  meters
}