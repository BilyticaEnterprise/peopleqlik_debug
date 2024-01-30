import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/AuthListeners/company_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Buttons/buttons.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/text_widgets.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/hide_keyboard.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';

import '../../configs/themes/app_bar_theme.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        HideShowKeyboard.hide(context);
      },
      child: const AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: Color(MyColor.colorWhite),
          body: BodyData()
        ),
      ),
    );
  }
}
class BodyData extends StatefulWidget {

  const BodyData({Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  late TextEditingController companyController;
  late FocusScopeNode nodeFocus;

  @override
  void initState() {
    nodeFocus = FocusScopeNode();
    companyController = TextEditingController();
    // companyController.text = 'pluspeopleqlik';
    // companyController.text = 'stgpeopleqlik';
    super.initState();
  }
  @override
  void dispose() {
    companyController.dispose();
    nodeFocus.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
          height: ScreenSize(context).heightOnly( 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height:ScreenSize(context).heightOnly(22),),
              Expanded(child: Lottie.asset("assets/company.json",fit: BoxFit.fitWidth,
                  //height: ScreenSize(context).heightOnly( 14),width: ScreenSize(context).heightOnly( 14),
                  repeat: true),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                child: Text(
                    '${CallLanguageKeyWords.get(context, LanguageCodes.companyCompanyName)}',
                  style: GetFont.get(
                      context,
                    fontSize: 2.4,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height:ScreenSize(context).heightOnly(2),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                child: Text(
                  '${CallLanguageKeyWords.get(context, LanguageCodes.companyCompanyDes)}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorBlack
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height:ScreenSize(context).heightOnly(4),),
              TextWidget(companyController,TextInputAction.done,nodeFocus, const Key('companyKey'),"${CallLanguageKeyWords.get(context, LanguageCodes.companyCompanyTextHint)}",icon:MdiIcons.officeBuildingOutline,isPasswordField: false,),
              SizedBox(height:ScreenSize(context).heightOnly(4),),
              ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.companyCompanyButton)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: companyPressed,),
              SizedBox(height:ScreenSize(context).heightOnly(6),),

            ],
          ),
        ),
    );
  }
  void companyPressed()
  {
    if(companyController.text.isNotEmpty)
      {
        CompanyModelListener().start(companyController.text, context);
      }
    else
      {
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.companyCompanyTextError)}');
      }
  }
}
