import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  String title;
  int? color;
  Widget? action;
  Function()? onBackTap;
  AppBarWidget(this.title, {this.action,this.color,this.onBackTap,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: true);
    return Container(
      padding:EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 4.6)),
      height: ScreenSize(context).heightOnly( 5.5),
      child: Stack(
        children: [
          Align(
            alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.centerRight:Alignment.centerLeft,
            child: ClipRRect(
              borderRadius:const BorderRadius.all(Radius.circular(5)),
              child: Material(
                color: const Color(MyColor.colorTransparent),
                child: InkWell(
                  splashColor: const Color(MyColor.colorGrey0),
                  onTap:onBackTap??(){
                    Navigator.pop(context);
                  },
                  child:  Padding(
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.5)),
                    child: SvgPicture.string(changeLanguage.languageEnum==LanguageEnum.arabic?SvgPicturesData.backRight:SvgPicturesData.back,width: ScreenSize(context).heightOnly( 3.0),height:ScreenSize(context).heightOnly( 3.0),color: Color(color??MyColor.colorBlack),),
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: GetFont.get(
                  context,
                    fontSize: 2.0,
                    color: color??MyColor.colorBlack,
                    fontWeight: FontWeight.w600
                ),
              )
          ),
          if(action!=null)...[
            Align(
              alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.centerLeft:Alignment.centerRight,
              child: action
            ),
          ]
        ],
      ),
    );
  }
}