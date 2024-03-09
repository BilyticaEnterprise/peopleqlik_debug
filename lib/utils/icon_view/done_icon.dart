import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../configs/colors.dart';
import '../../configs/icons.dart';
import '../screen_sizes.dart';
import 'get_icons.dart';

class DoneIcon extends StatelessWidget {
  final bool isSelected;
  final Function()? onTap;
  final double? size;
  const DoneIcon({this.isSelected = false,this.onTap,this.size,super.key});

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //     height: ScreenSize(context).heightOnly(2.5),
    //     width: ScreenSize(context).heightOnly(2.5),
    //     child: Icon(isSelected==true?MdiIcons.checkCircle:MdiIcons.circleOutline,color: Color(isSelected==true?MyColor.colorPrimary:MyColor.colorPrimary),size: ScreenSize(context).heightOnly(2.6),)
    // );
    return GetIcons(
      onTap: onTap,
      icon: isSelected==false?SvgPicturesData.notChecked:SvgPicturesData.checked,
      size: size??2.5,
      noPadding: onTap!=null?false:true,
      noColor: isSelected,
      iconColor: isSelected==false?MyColor.colorGrey2:MyColor.colorPrimary,
    );
  }
}
