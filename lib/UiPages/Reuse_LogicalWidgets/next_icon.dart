import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import 'package:provider/provider.dart';

import '../../src/colors.dart';
import '../../src/screen_sizes.dart';

class NextIcon extends StatelessWidget {
  const NextIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen:false);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Material(
        color: const Color(MyColor.colorGrey6),
        child: InkWell(
          splashColor: const Color(MyColor.colorGrey0),
          //onTap: (){},
          child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.75)),
              child: Icon(
                  Icons.arrow_forward_ios,
                size: ScreenSize(context).heightOnly( 2.0),
                color: const Color(MyColor.colorGrey3),
              )
          ),
        ),
      ),
    );
  }
}
