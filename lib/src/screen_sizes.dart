
import 'package:flutter/material.dart';

import '../mainCommon.dart';

class ScreenSize {
  static MediaQueryData? _queryData;

  ScreenSize(BuildContext context)
  {
    _queryData = MediaQuery.of(context);
  }

  dynamic heightOnly(dynamic percent) {

    dynamic size = (_queryData!.size.height-((_queryData?.padding.top??0)+(_queryData?.padding.bottom??0)))/100*percent;
    return size;
  }
  dynamic completeHeightOnly(dynamic percent) {
    dynamic size = (_queryData!.size.height)/100*percent;
    return size;
  }

  dynamic widthOnly(dynamic percent) {
    dynamic size = (_queryData!.size.width-((_queryData?.padding.left??0)+(_queryData?.padding.right??0)))/100*percent;
    return size;
  }

  double dptopx(BuildContext context, int dp) {
    _queryData = MediaQuery.of(context);
    double? devicePixelRatio = _queryData?.devicePixelRatio;
    //print('res ${WidgetsBinding.instance.window.devicePixelRatio}');
    double val = dp * devicePixelRatio!;
    //print('val ${val}');
    val = val / 2;
    val.round();
    return val;
  }
}