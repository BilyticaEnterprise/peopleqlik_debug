import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';

import '../../../src/colors.dart';
import '../../../src/screen_sizes.dart';
import 'bottom_sheet_header.dart';

class ShowBottomSheet
{
  static show(BuildContext context,{Function()? onDoneTap,Function(dynamic)? callBack,Widget? bottomNavigationBar,double? toolbarHeight,PreferredSizeWidget? bottomAppWidget,bool? enableDrag,bool? isDismissible,double? height,Widget? appBar,Widget? body,Widget? builder,String? optionalDefaultAppBarText,double? borderRadius,bool? expand,bool? topSafeRemove})
  {
    PrintLogs.printLogs('maxasdasd $height');
    showFlexibleBottomSheet(
      useRootNavigator: true,
      context: context,
      isDismissible: isDismissible??true,
      isExpand: expand??false,
      isCollapsible: true,
      minHeight: 0,
      maxHeight: (height??100)/100,
      initHeight: (height??100)/100,
      bottomSheetColor: const Color(MyColor.colorWhite),
        bottomSheetBorderRadius: BorderRadius.only(topRight: Radius.circular(borderRadius??15),topLeft: Radius.circular(borderRadius??15)),
      builder: (builderContext,scroll,value) => builder??SizedBox(
        height: ScreenSize(context).heightOnly(height??100),
        child: SafeArea(
          top: topSafeRemove??false,
          bottom: false,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(borderRadius??15),topLeft: Radius.circular(borderRadius??15)),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child:Scaffold(
                primary: topSafeRemove??false,
                extendBody: topSafeRemove??false,
                resizeToAvoidBottomInset: false,
                extendBodyBehindAppBar: false,
                backgroundColor: Color(MyColor.colorWhite),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Color(MyColor.colorWhite),
                  elevation: 0,
                  titleSpacing: 0,
                  toolbarHeight: ScreenSize(context).heightOnly(toolbarHeight??9),
                  title: appBar??HeaderBottomSheet(text: optionalDefaultAppBarText??'',doneTap: onDoneTap,),
                  bottom: bottomAppWidget,
                ),
                body: body,
                bottomNavigationBar: bottomNavigationBar,
              ),
            ),
          ),
        ),
      ),
    ).then((value){
      if(value!=null&&callBack!=null)
      {
        Future.delayed(const Duration(milliseconds: 200),(){callBack(value);});
      }
    });
    // showMaterialModalBottomSheet(
    //   useRootNavigator: true,
    //   context: context,
    //   isDismissible: isDismissible??true,
    //   expand: expand??false,
    //   enableDrag: enableDrag??true,
    //   animationCurve: Curves.easeIn,
    //   backgroundColor: const Color(MyColor.colorWhite),
    //   elevation: 6,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(topRight: Radius.circular(borderRadius??15),topLeft: Radius.circular(borderRadius??15))
    //   ),
    //   builder: (builderContext) => builder??SizedBox(
    //     height: ScreenSize(context).heightOnly(height??100),
    //     child: SafeArea(
    //       top: topSafeRemove??false,
    //       bottom: false,
    //       child: ClipRRect(
    //         borderRadius: BorderRadius.only(topRight: Radius.circular(borderRadius??15),topLeft: Radius.circular(borderRadius??15)),
    //         child: MediaQuery.removePadding(
    //           context: context,
    //           removeTop: true,
    //           child:Scaffold(
    //             primary: topSafeRemove??false,
    //             extendBody: topSafeRemove??false,
    //             resizeToAvoidBottomInset: false,
    //             extendBodyBehindAppBar: false,
    //             backgroundColor: Color(MyColor.colorWhite),
    //             appBar: AppBar(
    //               automaticallyImplyLeading: false,
    //               backgroundColor: Color(MyColor.colorWhite),
    //               elevation: 0,
    //               titleSpacing: 0,
    //               toolbarHeight: ScreenSize(context).heightOnly(toolbarHeight??9),
    //               title: appBar??HeaderBottomSheet(text: optionalDefaultAppBarText??'',doneTap: onDoneTap,),
    //               bottom: bottomAppWidget,
    //             ),
    //             body: body,
    //             bottomNavigationBar: bottomNavigationBar,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // ).then((value){
    //   if(value!=null&&callBack!=null)
    //     {
    //       Future.delayed(const Duration(milliseconds: 200),(){callBack(value);});
    //     }
    // });
  }

}