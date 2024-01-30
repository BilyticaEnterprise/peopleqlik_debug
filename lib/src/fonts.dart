import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:provider/provider.dart';

class GetFont
{
  static dynamic get(BuildContext context,{double? fontSize,FontWeight? fontWeight,int? color,LanguageEnum? languageEnum})
  {
    if(languageEnum!=null)
      {
        if(languageEnum == LanguageEnum.arabic)
          {
            return GoogleFonts.tajawal(fontSize: ScreenSize(context).heightOnly( fontSize??1.4),fontWeight: fontWeight,color: Color(color??MyColor.colorBlack));
          }
        else
          {
            return GoogleFonts.notoSans(fontSize: ScreenSize(context).heightOnly( fontSize??1.4),fontWeight: fontWeight,color: Color(color??MyColor.colorBlack));
          }
      }
    else
      {
        ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
        if(changeLanguage.languageEnum == LanguageEnum.arabic)
          {
            return GoogleFonts.tajawal(fontSize: ScreenSize(context).heightOnly( fontSize??1.4),fontWeight: fontWeight,color: Color(color??MyColor.colorBlack));
          }
        else
          {
            return GoogleFonts.notoSans(fontSize: ScreenSize(context).heightOnly( fontSize??1.4),fontWeight: fontWeight,color: Color(color??MyColor.colorBlack));

          }
      }
  }
}