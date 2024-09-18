import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/utils/account_enums.dart';

class AccountModel
{
  String header;
  String desc;
  IconData icon;
  int color;
  AccountPageType accountPageType;

  AccountModel({required this.header, required this.desc, required this.icon, required this.color,required this.accountPageType});
}