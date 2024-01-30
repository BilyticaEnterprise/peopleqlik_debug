import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';

import 'SkeletetonAnimation/skeleton_text.dart';

class ShimmerListView extends StatelessWidget {
  final double? height;
  final int? length;
  const ShimmerListView({this.height,this.length,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 6.6),ScreenSize(context).heightOnly( 2.0),ScreenSize(context).widthOnly( 6.6),ScreenSize(context).heightOnly( 15) ),
        itemBuilder: (context,index){
          return SkeletonAnimation(
            shimmerColor:const Color(MyColor.colorGrey0).withOpacity(0.2),
            gradientColor:const Color.fromARGB(0, 244, 244, 244),
            curve:Curves.easeInOutSine,
            child: Container(
              height: ScreenSize(context).heightOnly( height??12),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20),),
                color: Color(MyColor.colorWhite),
              ),
            ),
          );
        },
        separatorBuilder: (context,index){
          return SizedBox(
            height: ScreenSize(context).heightOnly( 1.5),
          );
        },
        itemCount: length??2);
  }
}
