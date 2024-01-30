import 'package:flutter/material.dart';

import '../mainCommon.dart';
import 'configs/flavor_config.dart';

void main(){
  var flavorConfig = FlavorConfig()
    ..appTitle = 'PayPeople Plus'
    ..imageLocation = 'assets/app_logos/juva_logo.png'
    ..theme = ThemeData.light()
    ..imageSvgIcon = 'assets/app_logos/juva_logo.png'
    ..appsNames = AppsNames.payPeoplePlus
    ..apiEndpoint = {"details":""}
  ..groupKey = 'com.bilytica.paypeople_plus.WORK_NOTIFIER'
  ..groupChannelId = 'PaypeoplePlus_Notifier'
  ..groupChannelName = 'PayPeople Plus';

  mainCommon(flavorConfig);
}