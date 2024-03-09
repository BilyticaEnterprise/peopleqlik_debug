import 'package:flutter/material.dart';


enum Endpoints { items, details }

enum AppsNames {peopleQlik,payPeoplePlus,peopleQlikDebug}
class FlavorConfig {
  String appTitle;
  String groupKey;
  String groupChannelId;
  String groupChannelName;
  AppsNames appsNames;
  Map<String, String>? apiEndpoint;
  String imageLocation;
  String imageSvgIcon;
  String applicationAndroidStoreId;
  String applicationIOSStoreId;
  late ThemeData theme;

  FlavorConfig({
    this.appTitle = 'PeopleQlik',
    this.apiEndpoint,
    this.groupKey = 'com.bilytica.peopleqlik.WORK_NOTIFIER',
    this.groupChannelId = 'PeopleQlik_Bilytica',
    this.groupChannelName = 'PeopleQlik Bilytica',
    this.appsNames = AppsNames.peopleQlik,
    this.imageSvgIcon = 'assets/avatar.png',
    this.imageLocation = 'assets/avatar.png',
    this.applicationAndroidStoreId = 'com.bilytica.peopleqliksapp',
    this.applicationIOSStoreId = ''
  })
  {
    theme = ThemeData.light();
  }
}