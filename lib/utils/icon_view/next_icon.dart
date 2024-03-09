import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:provider/provider.dart';

import '../../configs/colors.dart';
import '../screen_sizes.dart';

class NextIcon extends StatelessWidget {
  final int? color;
  final Function()? onTap;
  const NextIcon({this.color,this.onTap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen:false);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Material(
        color: Color(color??MyColor.colorGrey6),
        child: InkWell(
          splashColor: const Color(MyColor.colorGrey0),
          onTap: onTap,
          child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.75)),
              child: Icon(
                changeLanguage.languageEnum==LanguageEnum.english?Icons.arrow_forward_ios:Icons.arrow_back_ios,
                size: ScreenSize(context).heightOnly( 2.0),
                color: const Color(MyColor.colorGrey3),
              )
          ),
        ),
      ),
    );
  }
}
