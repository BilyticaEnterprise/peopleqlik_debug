import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

import '../../../../../../../src/colors.dart';
import '../../../../../../../src/screen_sizes.dart';
import '../../../../../../Reuse_Widgets/DatePickText/date_picker_text_style_1.dart';

class DateAndTimeWidget extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  const DateAndTimeWidget({required this.widget1,required this.widget2,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeLanguage languageEnum = Provider.of<ChangeLanguage>(context,listen: false);
    return Timeline.tileBuilder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: ConnectorThemeData(
          thickness: ScreenSize(context).heightOnly(0.4),
          color: const Color(0xffd3d3d3),
        ),
        indicatorTheme: IndicatorThemeData(
          size: ScreenSize(context).heightOnly(2),
        ),
      ),
      padding: const EdgeInsets.all(0),
      builder: TimelineTileBuilder.connected(
        contentsBuilder: (_, index) => Padding(
          padding: EdgeInsets.only(left: languageEnum.languageEnum == LanguageEnum.english?ScreenSize(context).widthOnly(2):0,right: languageEnum.languageEnum == LanguageEnum.arabic?ScreenSize(context).widthOnly(2):0),
          child: index==0?widget1:widget2
        ),
        connectorBuilder: (_, index, __) {
          return SolidLineConnector(color: Color(MyColor.colorPrimary));
        },
        indicatorBuilder: (_, index) {
          return DotIndicator(
            color: Color(MyColor.colorPrimary),
            child: Icon(
              index==1?Icons.first_page:Icons.last_page,
              color: Colors.white,
              size: ScreenSize(context).heightOnly( 1.4),
            ),
          );
        },
        itemExtentBuilder: (_, __) => ScreenSize(context).heightOnly(16),
        itemCount: 2,
      ),
    );
  }
}
