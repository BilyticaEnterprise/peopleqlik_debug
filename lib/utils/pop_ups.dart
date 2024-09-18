import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/submit_time_off_collector.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

class PopUpEnableGps extends StatefulWidget {
  String header,description,buttonText;
  PopUpEnableGps(this.header,this.description,this.buttonText);

  @override
  _PopUpEnableGpsState createState() => _PopUpEnableGpsState();
}

class _PopUpEnableGpsState extends State<PopUpEnableGps> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(MyColor.colorTransparent),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: double.infinity,
          height: ScreenSize(context).heightOnly(20),
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.all(ScreenSize(context).heightOnly(2.4)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(const Radius.circular(15)),
              color: const Color(MyColor.colorWhite),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0,3),
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 6
                )
              ]
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(widget.header,
                  style: GetFont.get(
                      context,
                      fontSize: 2.4,
                      fontWeight: FontWeight.w600,
                      color:MyColor.colorBlack
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(widget.description,
                  style: GetFont.get(
                      context,
                      fontSize: 1.8,
                      fontWeight: FontWeight.w400,
                      color:MyColor.colorGrey3
                  ),),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Material(
                  child: InkWell(
                    onTap: (){
                      // Provider.of<CheckUserLocation>(context,listen: false).checkAppBackground = true;
                      // AppSettings.openLocationSettings();
                      // Navigator.pop(context);
                    },
                    child: Text(widget.buttonText,
                      style: GetFont.get(
                          context,
                          fontSize: 2.4,
                          fontWeight: FontWeight.w600,
                          color:MyColor.colorPrimary
                      ), ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class AutoUnPaid{
  Future<bool> show(BuildContext context,AutoUnpaidCheck autoUnpaidCheck)
  {
    return showDialog(context: context,barrierColor: const Color(MyColor.colorWhite).withOpacity(0.4),builder: (BuildContext dialogContext)=>
        Localizations.override(
            context: context,
            locale: Provider.of<ChangeLanguage>(context,listen: false).languageEnum==LanguageEnum.arabic?Locale('ar','SA'):Locale('en','US'),
            child: AutoUnPiadPopUp(context,autoUnpaidCheck)))
        .then((value)
    {
      if(value!=null&&value is bool && value == true)
      {
        return true;
      }
      else
      {
        return false;
      }
    });
  }
}
class AutoUnPiadPopUp extends StatefulWidget {
  final BuildContext? contextIs;
  final AutoUnpaidCheck autoUnpaidCheck;
  const AutoUnPiadPopUp(this.contextIs, this.autoUnpaidCheck, {Key? key}) : super(key: key);

  @override
  _AutoUnPiadPopUpState createState() => _AutoUnPiadPopUpState();
}

class _AutoUnPiadPopUpState extends State<AutoUnPiadPopUp> {
  @override
  Widget build(BuildContext context) {
    return Material(color: const Color(MyColor.colorTransparent),child: getPopUp(context));
  }
  Widget getPopUp(context)
  {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: double.infinity,
          //height: ScreenSize(context).heightOnly(40),
          padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(6),horizontal: ScreenSize(context).heightOnly(2)),
          decoration: BoxDecoration(
            color: const Color(MyColor.colorWhite),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0,3),
                color: Color(MyColor.colorGrey0),
                blurRadius: 30,
                spreadRadius: 20
              )
            ]
          ),
          margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 4)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${CallLanguageKeyWords.get(context, LanguageCodes.p1Header)}',
                style: GetFont.get(
                    context,
                  fontSize: 2.2,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ScreenSize(context).heightOnly( 2),),
              Text(
                '${CallLanguageKeyWords.get(context, LanguageCodes.p1)} ${widget.autoUnpaidCheck.checkBalance} ${CallLanguageKeyWords.get(context, LanguageCodes.p2)} ',
                style: GetFont.get(
                    context,
                    fontSize:  1.6,
                    fontWeight: FontWeight.w400,
                    color: MyColor.colorBlack
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ScreenSize(context).heightOnly( 4),),
              Row(
                children: [
                  Expanded(child: ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.wait)}',buttonColor: MyColor.colorSecondary,textSize: 1.8,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: waitPressed,)),
                  SizedBox(width: ScreenSize(context).heightOnly( 1),),
                  Expanded(child: ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.confirm)}',buttonColor: MyColor.colorPrimary,textSize: 1.8,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: confirmPressed,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  confirmPressed()
  {
    Navigator.pop(widget.contextIs!,true);
  }
  waitPressed()
  {
    Navigator.pop(widget.contextIs!);
  }
}


class AlertYesNo{
  Future<bool> show(BuildContext context,AlertModel alertModel)
  {
    return showDialog(context: context,barrierColor: const Color(MyColor.colorWhite).withOpacity(0.4),builder: (BuildContext dialogContext)=>
        Localizations.override(
            context: context,
            locale: Provider.of<ChangeLanguage>(context,listen: false).languageEnum==LanguageEnum.arabic?Locale('ar','SA'):Locale('en','US'),
            child: _AlertYesNo(context,alertModel: alertModel,)))
        .then((value)
    {
      if(value!=null&&value is bool && value == true)
      {
        return true;
      }
      else
      {
        return false;
      }
    });
  }
}

class _AlertYesNo extends StatefulWidget {
  final BuildContext? contextIs;
  final AlertModel alertModel;
  const _AlertYesNo(this.contextIs, {required this.alertModel,Key? key}) : super(key: key);

  @override
  __AlertYesNoState createState() => __AlertYesNoState();
}

class __AlertYesNoState extends State<_AlertYesNo> {
  @override
  Widget build(BuildContext context) {
    return Material(color: const Color(MyColor.colorTransparent),child: getPopUp(context));
  }
  Widget getPopUp(context)
  {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: double.infinity,
          //height: ScreenSize(context).heightOnly(40),
          padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(6),horizontal: ScreenSize(context).heightOnly(2)),
          decoration: BoxDecoration(
              color: const Color(MyColor.colorWhite),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0,3),
                    color: Color(MyColor.colorGrey0),
                    blurRadius: 30,
                    spreadRadius: 20
                )
              ]
          ),
          margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 4)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.alertModel.header,
                style: GetFont.get(
                    context,
                    fontSize: 2.2,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ScreenSize(context).heightOnly( 2),),
              Text(
                widget.alertModel.description,
                style: GetFont.get(
                    context,
                    fontSize:  1.6,
                    fontWeight: FontWeight.w400,
                    color: MyColor.colorBlack
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ScreenSize(context).heightOnly( 4),),
              Row(
                children: [
                  Expanded(child: ButtonWidget(text: widget.alertModel.buttonNoText??'No',buttonColor: MyColor.colorSecondary,textSize: 1.8,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: waitPressed,)),
                  SizedBox(width: ScreenSize(context).heightOnly( 1),),
                  Expanded(child: ButtonWidget(text: widget.alertModel.buttonYesText??'',buttonColor: MyColor.colorPrimary,textSize: 1.8,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: confirmPressed,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  confirmPressed()
  {
    Navigator.pop(widget.contextIs!,true);
  }
  waitPressed()
  {
    Navigator.pop(widget.contextIs!);
  }
}

class AlertModel
{
  final String header;
  final String description;
  final String buttonYesText;
  final String buttonNoText;

  AlertModel({required this.header,required this.description, required this.buttonYesText,required this.buttonNoText});

}