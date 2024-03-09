import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../mainCommon.dart';

class SnackBarDesign {

  static happySnack(String? message)
  {
    if(GetNavigatorStateContext.rootScaffoldMessengerKey.currentState!=null&&(!GetNavigatorStateContext.rootScaffoldMessengerKey.currentState!.context.mounted)) {
      return;
    }
    if(GetNavigatorStateContext.rootScaffoldMessengerKey.currentState!=null&&GetNavigatorStateContext.rootScaffoldMessengerKey.currentState?.context!=null)
    {
      GetNavigatorStateContext.rootScaffoldMessengerKey.currentState?.showSnackBar(SnackBarDesign._getSessionSnackBar(GetNavigatorStateContext.navigatorKey.currentState!.context,message??'Server Error',color: MyColor.colorPrimary,icon: SvgPicturesData.success,textColor: MyColor.colorWhite,iconColor: MyColor.colorWhite));
    }
  }
  static warningSnack(String? message)
  {
    if(GetNavigatorStateContext.rootScaffoldMessengerKey.currentState!=null&&(!GetNavigatorStateContext.rootScaffoldMessengerKey.currentState!.context.mounted)) {
      return;
    }
    if(GetNavigatorStateContext.rootScaffoldMessengerKey.currentState!=null&&GetNavigatorStateContext.rootScaffoldMessengerKey.currentState?.context!=null)
    {
      GetNavigatorStateContext.rootScaffoldMessengerKey.currentState?.showSnackBar(SnackBarDesign._getSessionSnackBar(GetNavigatorStateContext.navigatorKey.currentState!.context,message??'Server Error',color: MyColor.colorA5,icon: SvgPicturesData.alert,textColor: MyColor.colorBlack,iconColor: MyColor.colorBlack,milliSeconds: 3000));
    }
  }
  static errorSnack(String? message,{double? bottom})
  {
    if(GetNavigatorStateContext.rootScaffoldMessengerKey.currentState!=null&&(!GetNavigatorStateContext.rootScaffoldMessengerKey.currentState!.context.mounted)) {
      return;
    }
    if(GetNavigatorStateContext.rootScaffoldMessengerKey.currentState!=null&&GetNavigatorStateContext.rootScaffoldMessengerKey.currentState?.context!=null)
      {
        GetNavigatorStateContext.rootScaffoldMessengerKey.currentState?.showSnackBar(SnackBarDesign._getSessionSnackBar(GetNavigatorStateContext.navigatorKey.currentState!.context,message??'',color: MyColor.colorRed,bottom: bottom,textColor: MyColor.colorWhite,iconColor: MyColor.colorWhite));
      }
  }

  static SnackBar _getSessionSnackBar(BuildContext context,String message, {int? textColor,int? iconColor,String? icon,int? color,int? milliSeconds,double? bottom})
  {
    return SnackBar(
      elevation: 6.0,
      backgroundColor: Color(color??MyColor.colorSecondary),
      duration: Duration(milliseconds: milliSeconds??2000),
      margin: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(6),0,ScreenSize(context).widthOnly(6),ScreenSize(context).heightOnly( bottom??4)),
      content: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.string(icon??SvgPicturesData.alert, color: Color(iconColor??MyColor.colorWhite), width: 24,height: 24,),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(message,style: GetFont.get(
                      context,
                      color: textColor??MyColor.colorWhite,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w400
                  ),),
                ),
              )
            ],
          )),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

}

