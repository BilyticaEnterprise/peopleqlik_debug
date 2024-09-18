import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class OrganizationChartEmptyView extends StatelessWidget {
  const OrganizationChartEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DividerByHeight(2),
        SvgPicture.string(
          SvgPicturesData.endHierarchy,
          height: ScreenSize(context).heightOnly(5),
          width: ScreenSize(context).heightOnly(5),
          colorFilter: const ColorFilter.mode(Color(MyColor.colorPrimary), BlendMode.srcIn),
        )
      ],
    );
  }
}
