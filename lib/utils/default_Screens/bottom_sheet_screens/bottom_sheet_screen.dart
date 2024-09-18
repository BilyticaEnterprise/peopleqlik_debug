import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/bottomSheetUi/bottom_sheet_header.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class DefaultBottomSheetScreen extends StatelessWidget {
  final Widget? bottomNavigationBar;
  final double? toolbarHeight;
  final PreferredSizeWidget? bottomAppWidget;
  final double? height;
  final Widget? appBar;
  final Widget body;
  final String? optionalDefaultAppBarText;
  final double? borderRadius;
  final bool? topSafeRemove;
  final bool? noAppBar;
  final Function()? onDoneTap;

  const DefaultBottomSheetScreen({
    required this.body,
    this.height,
    this.optionalDefaultAppBarText,
    this.toolbarHeight,
    this.appBar,
    this.borderRadius,
    this.bottomAppWidget,
    this.bottomNavigationBar,
    this.topSafeRemove,
    this.noAppBar,
    this.onDoneTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              backgroundColor: const Color(MyColor.colorWhite),
              appBar: noAppBar==true?null:AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color(MyColor.colorWhite),
                elevation: 0,
                scrolledUnderElevation:0,
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
    );
  }
}
