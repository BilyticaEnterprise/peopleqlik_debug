import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../Version1/viewModel/LanguageListeners/language_listener.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/fonts.dart';
import '../../../../../../../../configs/icons.dart';
import '../../../../../../../../utils/image_getter/cache_image.dart';
import '../../../../../../../../utils/date_formats.dart';
import '../../../../../../../../utils/screen_sizes.dart';
import '../../../../../../../../utils/wave_clipper.dart';

class TopPersonalView extends StatelessWidget {
  const TopPersonalView({super.key});

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height/100*22;
    double _width = MediaQuery.of(context).size.width;
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
    return Stack(
      children: [
        SizedBox(
          height: _height,
          width: _width,
          child: ClipPath(
            clipper: WaveClipper(),
            child: GetNetWorkImage(
              image: GetVariable.testPic,
              height: 22,
            ),
          ),
        ),
        SizedBox(
            height: _height,
            width: _width,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  width: _width,
                  height: _height,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                      child: Container(
                        height: ScreenSize(context).heightOnly( 20),
                        alignment: Alignment.center,
                        color: const Color(MyColor.colorWhite).withOpacity(0.8),
                      ),
                    ),

                  ),
                ),
              ],
            )
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: _height/100*44,),
            Align(
                alignment: Alignment.center,
                child: GetNetWorkImage(
                  image: 'https://media.licdn.com/dms/image/D4D03AQGyA8TuAL95XQ/profile-displayphoto-shrink_200_200/0/1692188087664?e=2147483647&v=beta&t=SxB69LHW1iLUQf8de0O8KyhuSreeraA5cawy2Qsz4Ug',
                  height: 18,
                  width: 18,
                  edgeInsets: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
                  boxShape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(MyColor.colorGrey2).withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                    BoxShadow(
                      color: const Color(MyColor.colorGrey0).withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(-3, -3), // changes position of shadow
                    ),
                  ],

                )
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 2.0),),
            Text(
              'Flutter Developer',
              style: GetFont.get(
                context,
                fontSize: 1.6,
                fontWeight: FontWeight.w400,
                color: MyColor.colorBlack,
              ),
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 0.1),),
            Text(
              'Abdul Muneeb Akram',
              style: GetFont.get(
                  context,
                  fontSize: 2.6,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
              ),
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 1.0),),
            RichText(
              text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: SvgPicture.string(
                          SvgPicturesData.birthDay,
                          width: ScreenSize(context).heightOnly( 3),
                          height: ScreenSize(context).heightOnly( 3),
                        )
                    ),
                    WidgetSpan(child: SizedBox(width: ScreenSize(context).heightOnly( 1),)),
                    TextSpan(
                      text: GetDateFormats().getFilterDate('2222-12-14T00:00:00')??'',
                      style: GetFont.get(
                        context,
                        fontSize: 1.8,
                        fontWeight: FontWeight.w400,
                        color: MyColor.colorGrey3,
                      ),
                    )
                  ]
              ),
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 1),),
            Text(
              'abmuneeb6@gmail.com',
              style: GetFont.get(
                context,
                fontSize: 1.8,
                fontWeight: FontWeight.w400,
                color: MyColor.colorGrey3,
              ),
            )
          ],
        ),
        Align(
          alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.centerRight:Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(ScreenSize(context).heightOnly(2)),
            child: ClipRRect(
              borderRadius:const BorderRadius.all(Radius.circular(5)),
              child: Material(
                color: const Color(MyColor.colorTransparent),
                child: InkWell(
                  splashColor: const Color(MyColor.colorGrey0),
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child:  Padding(
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.5)),
                    child: SvgPicture.string(changeLanguage.languageEnum==LanguageEnum.arabic?SvgPicturesData.backRight:SvgPicturesData.back,width: ScreenSize(context).heightOnly(3.2),height:ScreenSize(context).heightOnly( 3.2),color: Color(MyColor.colorBlack),),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
