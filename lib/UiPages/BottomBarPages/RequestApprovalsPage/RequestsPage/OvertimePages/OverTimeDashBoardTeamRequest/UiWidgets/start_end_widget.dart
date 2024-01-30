import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/colors.dart';

import '../../../../../../../src/screen_sizes.dart';

class StartEndWidget extends StatelessWidget {
  final Color? iconColor;
  final int backgroundColor;
  final double? width;
  final double? size;
  const StartEndWidget({this.iconColor = Colors.white,this.size,this.width,this.backgroundColor = MyColor.colorPrimary,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize(context).heightOnly(this.size??1.2);
    return SizedBox(
      width: width!=null?ScreenSize(context).widthOnly(width):null,
      child: Row(
        children: [
          ClipOval(
            child: Material(
              color: Color(backgroundColor),
              child: Padding(
                padding: EdgeInsets.all(size/100*40),
                child: Icon(
                  Icons.first_page,
                  color: iconColor,
                  size: size,
                ),
              ),
            ),
          ),
          Expanded(child: Container(height: size/100*30,color: Color(backgroundColor),)),
          ClipOval(
            child: Material(
              color: Color(backgroundColor),
              child: Padding(
                padding: EdgeInsets.all(size/100*40),
                child: Icon(
                  Icons.last_page,
                  color: iconColor,
                  size: size,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
