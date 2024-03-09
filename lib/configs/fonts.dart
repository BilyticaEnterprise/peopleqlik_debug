import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

class GetFont
{
  static dynamic get(BuildContext context,{double? fontSize,FontWeight? fontWeight,int? color,LanguageEnum? languageEnum,double? height})
  {
    if(languageEnum!=null)
      {
        if(languageEnum == LanguageEnum.arabic)
          {
            return GoogleFonts.tajawal(height: height,fontSize: ScreenSize(context).heightOnly( fontSize??1.4),fontWeight: fontWeight,color: Color(color??MyColor.colorBlack));
          }
        else
          {
            return GoogleFonts.notoSans(height: height,fontSize: ScreenSize(context).heightOnly( fontSize??1.4),fontWeight: fontWeight,color: Color(color??MyColor.colorBlack));
          }
      }
    else
      {
        ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
        if(changeLanguage.languageEnum == LanguageEnum.arabic)
          {
            return GoogleFonts.tajawal(height: height,fontSize: ScreenSize(context).heightOnly( fontSize??1.4),fontWeight: fontWeight,color: Color(color??MyColor.colorBlack));
          }
        else
          {
            return GoogleFonts.notoSans(height: height,fontSize: ScreenSize(context).heightOnly( fontSize??1.4),fontWeight: fontWeight,color: Color(color??MyColor.colorBlack));

          }
      }
  }
}