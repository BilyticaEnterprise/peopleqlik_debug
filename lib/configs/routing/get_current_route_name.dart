import 'package:flutter/material.dart';

String getCurrentRouteName(BuildContext context) {
  Route<dynamic>? currentRoute = ModalRoute.of(context);
  if (currentRoute != null) {
    return currentRoute.settings.name ?? '';
  }
  return '';
}