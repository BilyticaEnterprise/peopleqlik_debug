import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

class CheckInternetConnection extends GetChangeNotifier
{
  final Connectivity _connectivity = Connectivity();
  InternetConnectionEnum internetConnectionEnum = InternetConnectionEnum.checking;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      PrintLogs.printLogs(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.


    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        PrintLogs.printLogs('wifi');
        internetConnectionEnum = InternetConnectionEnum.available;
        notifyListeners();
        break;
      case ConnectivityResult.mobile:
        PrintLogs.printLogs('mobile');
        internetConnectionEnum = InternetConnectionEnum.available;
        notifyListeners();
        break;
      case ConnectivityResult.none:
        internetConnectionEnum = InternetConnectionEnum.notAvailable;
        PrintLogs.printLogs('false');
        notifyListeners();
        break;
      default:
        internetConnectionEnum = InternetConnectionEnum.notAvailable;
        PrintLogs.printLogs(' def false');
        notifyListeners();
        break;
    }
  }
}
enum InternetConnectionEnum
{
  available,notAvailable,checking
}
