import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../configs/colors.dart';
import '../screen_sizes.dart';

class TickIcon extends StatelessWidget {
  final bool? check;
  const TickIcon({this.check,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: ScreenSize(context).heightOnly( 2.5),
        width: ScreenSize(context).heightOnly( 2.5),
        child: Icon(check==true?MdiIcons.checkCircle:MdiIcons.circleOutline,color: const Color(MyColor.colorPrimary),size: ScreenSize(context).heightOnly(2.6),)
    );
  }
}
