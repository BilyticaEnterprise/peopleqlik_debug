import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/AuthListeners/login_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Buttons/buttons.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/text_widgets.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/hide_keyboard.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';

import '../../configs/themes/app_bar_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  late TextEditingController emailController,passwordController;
  late FocusScopeNode nodeFocus;

  @override
  void initState() {
    nodeFocus = FocusScopeNode();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // emailController.text = 'admin@al-jazera.sa';
    // passwordController.text = 'Pq@098!';
    // emailController.text = '240020510';
    // passwordController.text = '123456';
    //  emailController.text = '0210';
    //  passwordController.text = '123456';
    //  emailController.text = 'admin@abc.com';
    // passwordController.text = 'Pq@098!';
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            SizedBox(height:ScreenSize(context).heightOnly(14),),
            Expanded(child: Lottie.asset("assets/background.json",fit: BoxFit.fitHeight,
                //height: ScreenSize(context).heightOnly( 14),width: ScreenSize(context).heightOnly( 14),
                repeat: true),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
              child: Text(
                '${CallLanguageKeyWords.get(context, LanguageCodes.loginheader)}',
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
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 8.6)),
              child: Text(
                '${CallLanguageKeyWords.get(context, LanguageCodes.loginheaderAnswer)}',
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
            TextWidget(emailController,TextInputAction.next, nodeFocus, const Key('emailKey'),"${CallLanguageKeyWords.get(context, LanguageCodes.logintextEmail)}",icon:MdiIcons.emailOutline,isPasswordField: false,),
            SizedBox(height:ScreenSize(context).heightOnly(2),),
            TextWidget(passwordController,TextInputAction.done,nodeFocus, const Key('passwordKey'),"${CallLanguageKeyWords.get(context, LanguageCodes.logintextPassword)}",icon:MdiIcons.lockAlertOutline,isPasswordField: true,),
            SizedBox(height:ScreenSize(context).heightOnly(4),),
            ButtonWidget(text: 'Login',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: loginPressed,),
            SizedBox(height:ScreenSize(context).heightOnly(6),),

          ],
        ),
      ),
    );
  }
  void loginPressed()
  {
    if(emailController.text.isNotEmpty&&passwordController.text.isNotEmpty)
      {
        LoginModelListener().start(emailController.text, passwordController.text, context);
      }
    else
      {
        if(emailController.text.isEmpty)
          {
            SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.loginErrorEmail)}');
          }
        else if(passwordController.text.isEmpty)
        {
          SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.loginErrorPassword)}');
        }
      }
  }
}
