import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/lines_widget/horizontal_vertical_line.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class ChartBottomSeparatorWidget extends StatelessWidget {
  final int? length;
  const ChartBottomSeparatorWidget({this.length,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const DividerByHeight(1.2),
        HorizontalLine(width: ScreenSize(context).widthOnly(0.5),lineHeight: 2.2,color: MyColor.colorDarkBrown,marginVertical: 0,),
        SvgPicture.string(
          SvgPicturesData.arrowDown,
          height: ScreenSize(context).heightOnly(0.7),
          width: ScreenSize(context).heightOnly(0.7),
          colorFilter: const ColorFilter.mode(Color(MyColor.colorBlack), BlendMode.srcIn),
        ),
        if(length != null)...[
          const DividerByHeight(2.0),
          Text(
            '$length Team Members',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w500,
                color: MyColor.colorIndigo,
                fontSize: 1.4
            ),
          )
        ]
      ],
    );
  }
}
