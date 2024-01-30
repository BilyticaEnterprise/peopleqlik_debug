import 'package:flutter/material.dart';

import '../../src/colors.dart';
import '../../src/screen_sizes.dart';
import '../Reuse_Widgets/SkeletetonAnimation/skeleton_text.dart';

class SkeletonListWidget extends StatelessWidget {
  final int index;
  final double? height;
  final double? margin;
  const SkeletonListWidget(this.index,{this.height,this.margin,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize(context).heightOnly(height??12),
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(margin??0)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
              width: 1,
              color: const Color(MyColor.colorGrey7)
          )
      ),
      child: SkeletonAnimation(
          key: Key('requestShimmer$index'),
          shimmerColor:Colors.white70,
          gradientColor:const Color(MyColor.colorGreyPrimary).withOpacity(0.2),
          curve:Curves.fastOutSlowIn, child: Container()),
    );
  }
}
