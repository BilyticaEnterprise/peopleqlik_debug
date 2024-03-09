import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';

import '../../../Version1/Models/call_setting_data.dart';
import '../../../configs/colors.dart';
import '../../../configs/fonts.dart';
import '../../../utils/hide_keyboard.dart';
import '../../../configs/language_codes.dart';
import '../../../utils/screen_sizes.dart';

class HeaderBottomSheet extends StatelessWidget {
  final String? text;
  final Function()? doneTap;
  const HeaderBottomSheet({this.text,this.doneTap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
    return Container(
      width: ScreenSize(context).widthOnly(100),
      height: ScreenSize(context).heightOnly(7),
      padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 2.8),0,ScreenSize(context).widthOnly( 4.6),0),
      decoration: const BoxDecoration(
        color: Color(MyColor.colorWhite),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      ),
      child: Stack(
        children: [
          Align(
            alignment: changeLanguage.languageEnum == LanguageEnum.english?Alignment.centerLeft:Alignment.centerRight,
            child: ClipOval(
              child: Material(
                color: const Color(MyColor.colorTransparent),
                child: InkWell(
                    splashColor: const Color(MyColor.colorGrey0),
                    onTap: () async{
                      HideShowKeyboard.hide(context);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.6)),
                      child: Icon(
                        Icons.cancel_outlined,
                        size: ScreenSize(context).heightOnly( 3.2),
                        color: const Color(MyColor.colorBlack
                        ),
                      ),
                    )
                ),
              ),

            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Text(
                text??CallLanguageKeyWords.get(context, LanguageCodes.searchEmployeePanelHeader)??'',
                style: GetFont.get(
                    context,
                    fontSize:2.2,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                ),
              ),
            ),
          ),
          if(doneTap!=null)...[
            Align(
              alignment: changeLanguage.languageEnum == LanguageEnum.english?Alignment.centerRight:Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Material(
                  color: const Color(MyColor.colorPrimary),
                  child: InkWell(
                    splashColor: const Color(MyColor.colorGrey0),
                    onTap: doneTap,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1.4),vertical: ScreenSize(context).heightOnly( 0.6)),
                      child: Text(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.done)}',
                        style: GetFont.get(
                            context,
                            fontSize:1.3,
                            color: MyColor.colorWhite,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
