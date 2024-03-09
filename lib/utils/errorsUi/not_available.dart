import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../configs/icons.dart';
import '../../../utils/icon_view/get_icons.dart';


class NotAvailable extends StatelessWidget {
  String? lottieJson,header,description;
  double? topMargin;
  Widget? action;
  BoxFit? boxFit;
  double? height,width;
  NotAvailable(this.lottieJson,this.header,this.description,{Key? key,this.boxFit,this.action,this.topMargin,this.height,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: ScreenSize(context).heightOnly( topMargin??0),),
        Lottie.asset("assets/$lottieJson.json",
            fit: boxFit,
            height: ScreenSize(context).heightOnly(height??18),width: ScreenSize(context).heightOnly(width??18),repeat: true),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 8.6)),
          child: Text(
            '$header',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w600,
                fontSize: 2.2,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 1.5),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 8.6)),
          child: Text(
            '$description',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w400,
                fontSize: 1.6,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if(action!=null)...[
          const DividerByHeight(4),
          action!
        ]
      ],
    );
  }
}

// class NotAvailableSmall extends StatefulWidget {
//   double? height,width;
//   String? header,anim;
//   NotAvailableSmall(this.header,this.anim,{Key? key,this.height,this.width,}) : super(key: key);
//
//   @override
//   State<NotAvailableSmall> createState() => _NotAvailableSmallState();
// }
//
// class _NotAvailableSmallState extends State<NotAvailableSmall> with TickerProviderStateMixin {
//   late final AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Lottie.asset(
//           "assets/${widget.anim}.json",
//           controller: _controller,
//           height: ScreenSize(context).heightOnly( widget.height??18),width: ScreenSize(context).heightOnly(
//             widget.width??18),
//           onLoaded: (composition) {
//             // Configure the AnimationController with the duration of the
//             // Lottie file and start the animation.
//             _controller
//               ..duration = composition.duration
//               ..forward();
//             _controller.repeat();
//           },
//           repeat: true,
//         ),
//         SizedBox(height: ScreenSize(context).heightOnly( 2),),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 8.6)),
//           child: Text(
//             '${widget.header}',
//             style: GetFont.get(
//                 context,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 1.6,
//                 color: MyColor.colorBlack
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         SizedBox(height: ScreenSize(context).heightOnly( 2),),
//
//       ],
//     );
//   }
// }

class NotAvailableIcon extends StatelessWidget {
  String? icon,header,description;
  double? topMargin;
  Widget? action;
  BoxFit? boxFit;
  double? height,width;
  NotAvailableIcon({Key? key,this.icon,required this.header,required this.description,this.boxFit,this.action,this.topMargin,this.height,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: ScreenSize(context).heightOnly( topMargin??0),),
        GetIcons(icon: icon??SvgPicturesData.alert,size: 12,iconColor: MyColor.colorBlack,backgroundColor: MyColor.colorA5,opacity: 0.6,),
        SizedBox(height: ScreenSize(context).heightOnly(4),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 8.6)),
          child: Text(
            '$header',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w600,
                fontSize: 2.2,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 1.5),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 8.6)),
          child: Text(
            '$description',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w400,
                fontSize: 1.6,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if(action!=null)...[
          const DividerByHeight(4),
          action!
        ]
      ],
    );
  }
}
