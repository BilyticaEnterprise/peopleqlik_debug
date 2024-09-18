
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/size_configs/size_config.dart';

class GetSizeConfig extends SizeConfig{

  late MediaQueryData _mediaQueryData;
  late double _screenWidth;
  late double _screenHeight;
  late double _blockSizeHorizontal;
  late double _blockSizeVertical;

  late double _safeAreaHorizontal;
  late double _safeAreaVertical;
  late double _safeBlockHorizontal;
  late double _safeBlockVertical;

  GetSizeConfig();

  GetSizeConfig.of(BuildContext context)
  {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    _safeBlockHorizontal = (_screenWidth -
        _safeAreaHorizontal) / 100;
    _safeBlockVertical = (_screenHeight -
        _safeAreaVertical) / 100;
  }

  @override
  config(BuildContext context)
  {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    _safeBlockHorizontal = (_screenWidth -
        _safeAreaHorizontal) / 100;
    _safeBlockVertical = (_screenHeight -
        _safeAreaVertical) / 100;
  }


  @override
  double getTextSize(double percent) {
    return (((_safeBlockHorizontal + _safeBlockVertical)/2) * percent);
  }

  @override
  double getTotalHeight() {
    return _screenHeight;
  }

  @override
  double getTotalWidth() {
    return _screenWidth;
  }

  @override
  double getHeightWithSafe(double percent) {
    return _safeBlockVertical * percent;
  }

  @override
  double getWidthWithSafe(double percent) {
    return _safeBlockHorizontal * percent;
  }

  @override
  double getHeightNotSafe(double percent) {
    return _blockSizeVertical * percent;
  }

  @override
  double getWidthNotSafe(double percent) {
    return _blockSizeHorizontal * percent;
  }

  @override
  bool checkIfSizeConfigWorking() {
    return _screenHeight >= 0 && _screenWidth>=0;
  }

}