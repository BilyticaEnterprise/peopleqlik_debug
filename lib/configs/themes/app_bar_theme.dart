

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../src/colors.dart';

var appBarThemeStyle = SystemUiOverlayStyle(
  statusBarColor: const Color(MyColor.colorWhite),
  statusBarBrightness: Platform.isIOS?Brightness.light:Brightness.dark,
  statusBarIconBrightness: Platform.isIOS?Brightness.light:Brightness.dark,
  systemNavigationBarColor: Colors.black,
);

