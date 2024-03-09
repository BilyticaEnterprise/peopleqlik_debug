import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class CircularIndicatorCustomized extends StatelessWidget {
  final double? marginTop,marginBottom,size;
  const CircularIndicatorCustomized({this.marginTop,this.marginBottom,this.size,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:ScreenSize(context).heightOnly( marginTop??0) ,bottom: ScreenSize(context).heightOnly( marginBottom??8)),
      child: Center(child: Lottie.asset("assets/loader_1.json",
                width: ScreenSize(context).heightOnly( size??18),
                height: ScreenSize(context).heightOnly( size??18),
                fit: BoxFit.fitWidth,repeat: true)
      ),
    );
  }
}
