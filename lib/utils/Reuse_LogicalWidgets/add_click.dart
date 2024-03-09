import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../configs/colors.dart';
import '../screen_sizes.dart';

class AddIconClick extends StatelessWidget {
  final Function()? onClick;
  const AddIconClick({required this.onClick,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Material(
        color: const Color(MyColor.colorPrimary),
        child: InkWell(
          splashColor: const Color(MyColor.colorGrey0),
          onTap: onClick,
          child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.8)),
              child: Icon(
                MdiIcons.plus,
                size: ScreenSize(context).heightOnly( 2.8),
                color: const Color(MyColor.colorWhite),
              )
          ),
        ),
      ),
    );
  }
}
