import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';

import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import '../../../../../../../configs/colors.dart';
import '../../../../../../../configs/fonts.dart';
import '../../../../../../../utils/screen_sizes.dart';

class PromptView extends StatelessWidget {
  final String header;
  final String description;
  final String anim;
  final Function()? doneTap;
  final Function()? extraTap;
  final String? doneTapText;
  final String? extraTapText;
  const PromptView({required this.header,required this.description,required this.anim,this.doneTap,this.extraTap,this.doneTapText,this.extraTapText,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(anim,fit: BoxFit.fitHeight,height: ScreenSize(context).heightOnly(30),repeat: true),
        const DividerByHeight(2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
          child: Text(
            header,
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w600,
                fontSize: 2.2,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const DividerByHeight(2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
          child: Text(
            description,
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w400,
                fontSize: 1.8,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const DividerByHeight(4),
        if(doneTap != null)...[
          ButtonWidget(onPressed: doneTap!, text: doneTapText??'',width: ScreenSize(context).heightOnly( 23),height: 6.0,weight: FontWeight.w600,textSize: 1.8,),
          const DividerByHeight(2),
        ],
        if(extraTap != null)...[
          ButtonWidget(onPressed: extraTap!, text: extraTapText??'',width: ScreenSize(context).heightOnly( 20),height: 6.0,buttonColor: MyColor.colorBlack,textColor: MyColor.colorWhite,weight: FontWeight.w600,textSize: 1.8,),
          const DividerByHeight(2),
        ],
        const DividerByHeight(8),

      ],
    );
  }
}
