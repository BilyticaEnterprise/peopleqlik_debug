import 'package:flutter/material.dart';

import '../mainCommon.dart';
import 'configs/flavor_config.dart';

void main(){
  var flavorConfig = FlavorConfig()
    ..appTitle = 'PeopleQlik Debug'
    ..imageLocation = 'assets/app_logos/cloudpital_logo.png'
    ..theme = ThemeData.light()
    ..imageSvgIcon = 'assets/avatar.png'
    ..appsNames = AppsNames.peopleQlikDebug
    ..apiEndpoint = {"details":""}
    ..groupKey = 'com.bilytica.peopleqlik_debug.WORK_NOTIFIER'
    ..groupChannelId = 'PeopleQlik_Debug'
    ..groupChannelName = 'PeopleQlik Debug';


  mainCommon(flavorConfig);
}