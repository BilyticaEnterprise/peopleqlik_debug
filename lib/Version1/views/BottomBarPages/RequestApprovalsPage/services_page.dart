import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/get_assets.dart';

class PaySlipPage extends StatelessWidget {
  const PaySlipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInternetConnection>(
      builder: (context,data,child) {
        if(data.internetConnectionEnum == InternetConnectionEnum.available)
          {
            return Column(
              children: [
                MiddleTimeSheetWidget(header: '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr41)}',text: '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr42)}',color1: 0xffF8C8C7,color2: 0xffF8C8C7,lottie: 'approve',),
                MiddleTimeSheetWidget(header: '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr39)}',text: '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr40)}',color1:0xffF2F1C9,color2: 0xffF2F1C9,lottie: 'request',),
                MiddleTimeSheetWidget(header: '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr37)}',text: '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr38)}',color1:0xffC8EED4,color2: 0xffC8EED4,lottie: 'payslip',),
              ],
            );
          }
        else
        {
          return NotAvailable(GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
        }
      }
    );
  }
}
class MiddleTimeSheetWidget extends StatelessWidget {
  final String? header,text,lottie;
  final int? color1,color2;
  final void Function()? onClick;
  const MiddleTimeSheetWidget({this.header,this.text,this.lottie,this.onClick,this.color1,this.color2,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6),vertical: ScreenSize(context).heightOnly( 2.0)),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.3,0.8],
              colors: [Color(color1??MyColor.colorT1),Color(color2??MyColor.colorT3)]
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          //color: const Color(MyColor.colorWhite),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 0.0,
                blurRadius: 14,
                offset: const Offset(3.0, 3.0)),
            BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 0.0,
                blurRadius: 14 / 2.0,
                offset: const Offset(3.0, 3.0)),
            BoxShadow(
                color: Colors.grey.shade50,
                spreadRadius: 2.0,
                blurRadius: 14,
                offset: const Offset(0.0, -3.0)),
            BoxShadow(
                color: Colors.grey.shade50,
                spreadRadius: 2.0,
                blurRadius: 14 / 2,
                offset: const Offset(0.0, -3.0)),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Material(
            color: const Color(MyColor.colorTransparent),
            child: InkWell(
              splashColor: const Color(MyColor.colorGrey0),
              onTap: (){
                if(header == '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr41)}')
                  {
                    Navigator.pushNamed(context, CurrentPage.ApprovalPage);
                  }
                else if(header == '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr39)}')
                {
                  Navigator.pushNamed(context, CurrentPage.RequestPage);
                }
                else if(header == '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr37)}')
                {
                  Navigator.pushNamed(context, CurrentPage.PayslipPage);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(Provider.of<ChangeLanguage>(context,listen: false).languageEnum == LanguageEnum.arabic?0:ScreenSize(context).heightOnly( 1.5), ScreenSize(context).heightOnly( 1.5), Provider.of<ChangeLanguage>(context,listen: false).languageEnum == LanguageEnum.arabic?ScreenSize(context).heightOnly( 1.5):0, ScreenSize(context).heightOnly( 1.5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            header??'',
                            style: GetFont.get(
                                context,
                                fontWeight: FontWeight.w600,
                                fontSize: 2.2,
                                color: MyColor.colorBlack
                            ),
                          ),
                          SizedBox(height: ScreenSize(context).heightOnly( 0.5),),
                          Text(
                              text??'',
                              style: GetFont.get(
                                  context,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 1.5,
                                  color: MyColor.colorBlack
                              ),
                          ),
                          SizedBox(height: ScreenSize(context).heightOnly( 2),),
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            child: Material(
                              color: const Color(MyColor.colorGrey6),
                              child: Padding(
                                  padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.75)),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: ScreenSize(context).heightOnly( 2.0),
                                    color: const Color(MyColor.colorGrey3),
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: ScreenSize(context).heightOnly( 1.0)),
                    child: Lottie.asset("assets/${lottie??"timesheet"}.json",fit: BoxFit.fitWidth,height: ScreenSize(context).heightOnly( 14),width: ScreenSize(context).heightOnly( 14),repeat: true),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
