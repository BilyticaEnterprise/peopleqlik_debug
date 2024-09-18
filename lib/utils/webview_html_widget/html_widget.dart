import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class HtmlDetailWidget extends StatelessWidget {
  String? text;
  HtmlDetailWidget(this.text);
  @override
  Widget build(BuildContext context) {
    print('ajnsjdas ${text}');
    return HtmlWidget(
      text!,

      // all other parameters are optional, a few notable params:

      // specify custom styling for an element
      // see supported inline styling below
      customStylesBuilder: (element) {
        if (element.localName == 'table') {
          return {'font-size': '12.0px'};
        }

        return null;
      },

      customWidgetBuilder: (element) {
        // if (element.attributes['foo'] == 'bar') {
        //   // render a custom block widget that takes the full width
        //   return FooBarWidget();
        // }
        //
        // if (element.attributes['fizz'] == 'buzz') {
        //   // render a custom widget inline with surrounding text
        //   return InlineCustomWidget(
        //     child: FizzBuzzWidget(),
        //   )
        // }

        return null;
      },

      // this callback will be triggered when user taps a link
      onTapUrl: (url) {return true;},

      // select the render mode for HTML body
      // by default, a simple `Column` is rendered
      // consider using `ListView` or `SliverList` for better performance
      renderMode: RenderMode.listView,

      // set the default styling for text
      textStyle: TextStyle(fontSize: ScreenSize(context).heightOnly( 1.4)),
    );



    // return Html(
    //   shrinkWrap: true,
    //   data: text,
    //   style: {
    //     'h1':Style(
    //         fontSize: FontSize(ScreenSize(context).heightOnly( 2.2)),
    //         alignment: Alignment.center,
    //         textAlign: TextAlign.center,
    //         color: const Color(MyColor.colorBlack),
    //         fontFamily: 'Poppins',
    //         margin: Margins.only(bottom: ScreenSize(context).heightOnly(8),top: 6.0),
    //         fontWeight: FontWeight.w500
    //     ),
    //     'h4':Style(
    //         fontSize: FontSize(ScreenSize(context).heightOnly( 1.4)),
    //         alignment: Alignment.center,
    //         textAlign: TextAlign.center,
    //         fontFamily: 'Poppins',
    //         margin: Margins.all(0),
    //         fontWeight: FontWeight.w700
    //     ),
    //     'h3':Style(
    //       fontSize: FontSize(ScreenSize(context).heightOnly( 1.8)),
    //       alignment: Alignment.center,
    //       textAlign: TextAlign.start,
    //       fontWeight: FontWeight.w600,
    //       color: const Color(MyColor.colorBlack),
    //       fontFamily: 'Poppins',
    //       margin: Margins.symmetric(vertical: 20),
    //     ),
    //     'p':Style(
    //         whiteSpace: WhiteSpace.normal,
    //         fontSize: FontSize(ScreenSize(context).heightOnly( 1.6)),
    //         fontWeight: FontWeight.w400,
    //         wordSpacing: 1.4,
    //         lineHeight: LineHeight.em(1.2),
    //         color: const Color(MyColor.colorBlack),
    //         fontFamily: 'Open Sans',
    //         margin: Margins.symmetric(vertical:ScreenSize(context).heightOnly( 0.5))
    //     ),
    //     'p1':Style(
    //         fontSize: FontSize(ScreenSize(context).heightOnly( 1.6)),
    //         fontWeight: FontWeight.w600,
    //         wordSpacing: 1.1,
    //         color: const Color(MyColor.colorBlack),
    //         fontFamily: 'Open Sans',
    //         margin: Margins.symmetric(vertical:ScreenSize(context).heightOnly( 0.5))
    //     ),
    //     'li':Style(
    //         fontSize: FontSize(ScreenSize(context).heightOnly( 1.6)),
    //         fontWeight: FontWeight.w400,
    //         wordSpacing: 1.1,
    //         fontFamily: 'Open Sans',
    //         margin: Margins.all(0)
    //     ),
    //   },
    //
    // );
  }
}