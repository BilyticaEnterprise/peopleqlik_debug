import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/domain/model/document_policy_acknowledge_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/tick_icon.dart';
import 'package:peopleqlik_debug/utils/Webview_Html_Widget/html_widget.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_single_button.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/icon_view/get_icons.dart';
import 'package:peopleqlik_debug/utils/icon_view/icon_only.dart';
import 'package:peopleqlik_debug/utils/lines_widget/horizontal_vertical_line.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';

class DocumentHtmlView extends StatelessWidget {
  final DocumentPolicyAcknowledgeModel? model;

  const DocumentHtmlView({this.model,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(model?.htmlText == null||(model?.htmlText != null&&model!.htmlText!.isEmpty))...[
          const DividerByHeight(6),
          const Center(
            child: GetIconOnly(
              icon: SvgPicturesData.file,
              color: MyColor.colorGrey2,
              size: 12,
            ),
          ),
          const DividerByHeight(3),
          Center(
            child: Text(
              model?.title??'',
              style: GetFont.get(
                  context,
                  fontWeight: FontWeight.w600,
                  fontSize: 1.8,
                  color: MyColor.colorBlack
              ),
            ),
          )
        ],
        if(model?.htmlText != null&&model!.htmlText!.isNotEmpty)...[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(4)),
              child: HtmlDetailWidget(model?.htmlText),
            ),
          ),
        ],
        if(model?.htmlText == null||(model?.htmlText != null&&model!.htmlText!.isEmpty))...[
          Expanded(child: Container()),
        ],
        if(model?.htmlText != null&&model!.htmlText!.isNotEmpty)...[
          const DividerByHeight(2),
          const HorizontalLine(lineHeight: 0.15,marginHorizontal: 6,),
        ],
        _ConsentText(text: model?.title),
        const DividerByHeight(3),
        BottomSingleButton(
          text: CallLanguageKeyWords.get(context, LanguageCodes.done)??'',
          onPressed: () {
            Navigator.pop(context,true);
          },
        )
      ],
    );
  }
}

class _ConsentText extends StatelessWidget {
  final String? text;
  const _ConsentText({this.text,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6)),
      child: RichText(
        text: TextSpan(
            children: [
              WidgetSpan(child: TickIcon(check: true,)),
              TextSpan(
                text: '  ${CallLanguageKeyWords.get(context, LanguageCodes.iAgreeText)??''}',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w500,
                    fontSize: 1.6,
                    height: 1.6,
                    color: MyColor.colorBlack
                ),
              ),
              TextSpan(
                text: ' $text',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    fontSize: 1.6,
                    color: MyColor.colorPrimary
                ),
              )
            ]
        ),
      ),
    );
  }
}
