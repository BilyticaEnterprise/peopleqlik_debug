import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class PickerPager extends StatelessWidget {
  const PickerPager(
      {Key? key, this.customHeight, this.customWidth, required this.selector,required this.theme})
      : super(key: key);
  final double? customHeight;
  final double? customWidth;
  final Widget selector;
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize(context).heightOnly( 30),
      width: ScreenSize(context).widthOnly( 80),
      child: Theme(
        data: theme.copyWith(
          buttonTheme: ButtonThemeData(
            padding: EdgeInsets.all(5.0),
            shape: CircleBorder(),
            height: ScreenSize(context).heightOnly( 3),
            minWidth: 4.0,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              ScaleTransition(child: child, scale: animation),
          child: selector,
        ),
      ),
    );
  }
}
