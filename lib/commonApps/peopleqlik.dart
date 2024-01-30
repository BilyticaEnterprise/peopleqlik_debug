import 'package:flutter/material.dart';

import '../mainCommon.dart';
import 'configs/flavor_config.dart';

void main(){
  var flavorConfig = FlavorConfig()
    ..appTitle = 'PeopleQlik'
    ..imageLocation = 'assets/app_logos/cloudpital_logo.png'
    ..theme = ThemeData.light()
    ..imageSvgIcon = 'assets/avatar.png'
    ..appsNames = AppsNames.peopleQlik
    ..apiEndpoint = {"details":""}
  ..groupKey = 'com.bilytica.peopleqlik.WORK_NOTIFIER'
  ..groupChannelId = 'PeopleQlik_Bilytica'
  ..groupChannelName = 'PeopleQlik Bilytica';


  mainCommon(flavorConfig);
}