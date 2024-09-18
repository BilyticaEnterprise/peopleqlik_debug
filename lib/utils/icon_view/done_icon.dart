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
    return GetIcons(
      onTap: onTap,
      icon: isSelected==false?SvgPicturesData.notChecked:SvgPicturesData.checked,
      size: size??2.5,
      noPadding: onTap!=null?false:true,
      noColor: isSelected,
      color: isSelected==false?MyColor.colorGrey2:MyColor.colorPrimary,
    );
  }
}
