import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import 'package:provider/provider.dart';

import '../../../../Version1/Models/call_setting_data.dart';
import '../../../../configs/colors.dart';
import '../../../../utils/Appbars/app_bar.dart';
import '../../../../utils/hide_keyboard.dart';
import '../../../../configs/language_codes.dart';
import '../../lottie_anims_utils/lottie_string.dart';
import '../../../../utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import '../../Buttons/buttons.dart';
import 'default_screen_bodies.dart';


class GetPageStarterScaffoldStateLess extends StatelessWidget {
  final int? screenColor;
  final double? paddingHorizontally;
  final bool? pinned,float,withScrollView;
  final String? title;
  final bool? checkEmployeeIfExistInCurrentCompany;
  final Function()? employeeChangeCurrentCompanyTap;
  final double? toolbarHeight;
  final PreferredSizeWidget? bottomViewOffAppBar;
  final bool? addToolBarHeight;
  final Widget body;
  final bool? checkForInternet;
  final Widget? appBar;
  final SliverAppBar? sliverAppBar;
  final Widget? flexibleSpace;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool? setLocationCheck;
  final bool? scrollPhysicsNever;
  final Widget? action;
  final Function()? onBackTap;
  const GetPageStarterScaffoldStateLess({
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBar,
    this.sliverAppBar,
    this.withScrollView,
    this.paddingHorizontally = 0,
    this.bottomViewOffAppBar,
    this.pinned,
    this.scrollPhysicsNever,
    this.float,
    this.checkForInternet,
    this.toolbarHeight,
    this.setLocationCheck,
    this.checkEmployeeIfExistInCurrentCompany = false,
    this.employeeChangeCurrentCompanyTap,
    this.addToolBarHeight = false,
    this.screenColor,
    this.action,
    this.flexibleSpace,
    this.onBackTap,
    required this.body,
    this.title,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        HideShowKeyboard.hide(context);
      },
      child: Scaffold(
        backgroundColor: const Color(MyColor.colorWhite),
        body: NestedScrollView(
            physics: scrollPhysicsNever==true?const NeverScrollableScrollPhysics():null,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                sliverAppBar??(addToolBarHeight==true? SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: pinned??false,
                  floating: pinned==true?false:float??true,
                  snap: pinned==true?false:float??true,
                  backgroundColor: const Color(MyColor.colorWhite),
                  title: appBar??AppBarWidget(title??'',action: action,onBackTap: onBackTap,),
                  titleSpacing: 0,
                  toolbarHeight: ScreenSize(context).heightOnly(toolbarHeight??19),
                  elevation: 0,
                  bottom: bottomViewOffAppBar,
                  flexibleSpace: flexibleSpace!=null?FlexibleSpaceBar(
                    background: flexibleSpace,
                  ):null,
                ):SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: pinned??false,
                  floating: pinned==true?false:float??true,
                  snap: pinned==true?false:float??true,
                  backgroundColor: const Color(MyColor.colorWhite),
                  title: appBar??AppBarWidget(title??'',action: action,onBackTap: onBackTap,),
                  titleSpacing: 0,
                  elevation: 0,
                  bottom: bottomViewOffAppBar,
                  flexibleSpace: flexibleSpace!=null?FlexibleSpaceBar(
                    background: flexibleSpace,
                  ):null,
                )
                )
              ];
            },
            body: checkEmployeeIfExistInCurrentCompany==true?
            Consumer<GlobalSelectedEmployeeController>(
              builder: (context, employeeCheck, child) {
                if(employeeCheck.apiStatus == ApiStatus.done)
                  {
                    return withScrollView==true?GetBodyWidgetWithScrollView(body: body,checkForInternet: checkForInternet,paddingHorizontally:paddingHorizontally!):GetBodyWidgetWithOutScrollView(checkForInternet: checkForInternet,body: body,paddingHorizontally:paddingHorizontally);
                  }
                else
                  {
                    return NotAvailable(LottieString.noPermission, '${CallLanguageKeyWords.get(context, LanguageCodes.notAllowedEmployeeHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.notAllowedEmployeeValue)}',topMargin: 2,width: 40,boxFit: BoxFit.fitWidth,height: 33,action: employeeChangeCurrentCompanyTap!=null?ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.changeEmployee)}',buttonColor: MyColor.colorPrimary,textSize: 2.0,textColor: MyColor.colorWhite,height: 7.0,width: ScreenSize(context).widthOnly(60),paddingHorizontal: ScreenSize(context).heightOnly(1.2),elevation: 0,weight: FontWeight.w600,onPressed: employeeChangeCurrentCompanyTap! ):null,);
                  }
              }
            )
                :
            withScrollView==true?GetBodyWidgetWithScrollView(body: body,checkForInternet: checkForInternet,paddingHorizontally:paddingHorizontally!):GetBodyWidgetWithOutScrollView(checkForInternet: checkForInternet,body: body,paddingHorizontally:paddingHorizontally)
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}



class GetPageStarterScaffoldStateFull extends StatefulWidget {
  final int? screenColor;
  final double? paddingHorizontally;
  final bool? pinned,float,withScrollView;
  final bool textFieldScreen;
  final String? title;
  final bool? checkEmployeeIfExistInCurrentCompany;
  final Function()? employeeChangeCurrentCompanyTap;
  final double? toolbarHeight;
  final PreferredSizeWidget? bottomViewOffAppBar;
  final bool? addToolBarHeight;
  final Widget body;
  final bool? checkForInternet;
  final Widget? appBar;
  final SliverAppBar? sliverAppBar;
  final Widget? flexibleSpace;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool? setLocationCheck;
  final bool? scrollPhysicsNever;
  final Widget? action;
  final Function()? onBackTap;
  const GetPageStarterScaffoldStateFull({
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBar,
    this.sliverAppBar,
    this.withScrollView,
    this.paddingHorizontally = 0,
    this.bottomViewOffAppBar,
    this.pinned,
    this.scrollPhysicsNever,
    this.float,
    this.checkForInternet,
    this.toolbarHeight,
    this.setLocationCheck,
    this.checkEmployeeIfExistInCurrentCompany = false,
    this.employeeChangeCurrentCompanyTap,
    this.addToolBarHeight = false,
    this.textFieldScreen = false,
    this.screenColor,
    this.action,
    this.flexibleSpace,
    this.onBackTap,
    required this.body,
    this.title,
    Key? key}) : super(key: key);

  @override
  State<GetPageStarterScaffoldStateFull> createState() => _GetPageStarterScaffoldStateFullState();
}

class _GetPageStarterScaffoldStateFullState extends State<GetPageStarterScaffoldStateFull> with WidgetsBindingObserver{

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if(widget.textFieldScreen == true)
      {
        if (!MediaQuery.of(context).viewInsets.bottom.isNaN && MediaQuery.of(context).viewInsets.bottom == 0) {
          _resetScrollPosition();
        }
      }
  }

  void _resetScrollPosition() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        HideShowKeyboard.hide(context);
      },
      child: Scaffold(
        backgroundColor: const Color(MyColor.colorWhite),
        body: NestedScrollView(
            controller: widget.textFieldScreen == true?_scrollController:null,
            physics: widget.scrollPhysicsNever==true?const NeverScrollableScrollPhysics():null,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                widget.sliverAppBar??(widget.addToolBarHeight==true? SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: widget.pinned??false,
                  floating: widget.pinned==true?false:widget.float??true,
                  snap: widget.pinned==true?false:widget.float??true,
                  backgroundColor: const Color(MyColor.colorWhite),
                  title: widget.appBar??AppBarWidget(widget.title??'',action: widget.action,onBackTap: widget.onBackTap,),
                  titleSpacing: 0,
                  scrolledUnderElevation:0,
                  toolbarHeight: ScreenSize(context).heightOnly(widget.toolbarHeight??19),
                  elevation: 0,
                  bottom: widget.bottomViewOffAppBar,
                  flexibleSpace: widget.flexibleSpace!=null?FlexibleSpaceBar(
                    background: widget.flexibleSpace,
                  ):null,
                ):SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: widget.pinned??false,
                  floating: widget.pinned==true?false:widget.float??true,
                  snap: widget.pinned==true?false:widget.float??true,
                  backgroundColor: const Color(MyColor.colorWhite),
                  title: widget.appBar??AppBarWidget(widget.title??'',action: widget.action,onBackTap: widget.onBackTap,),
                  titleSpacing: 0,
                  scrolledUnderElevation:0,
                  elevation: 0,
                  bottom: widget.bottomViewOffAppBar,
                  flexibleSpace: widget.flexibleSpace!=null?FlexibleSpaceBar(
                    background: widget.flexibleSpace,
                  ):null,
                )
                )
              ];
            },
            body: widget.checkEmployeeIfExistInCurrentCompany==true?
            Consumer<GlobalSelectedEmployeeController>(
                builder: (context, employeeCheck, child) {
                  if(employeeCheck.apiStatus == ApiStatus.done)
                  {
                    return widget.withScrollView==true?GetBodyWidgetWithScrollView(body: widget.body,checkForInternet: widget.checkForInternet,paddingHorizontally:widget.paddingHorizontally!):GetBodyWidgetWithOutScrollView(checkForInternet: widget.checkForInternet,body: widget.body,paddingHorizontally:widget.paddingHorizontally);
                  }
                  else
                  {
                    return NotAvailable(LottieString.noPermission, '${CallLanguageKeyWords.get(context, LanguageCodes.notAllowedEmployeeHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.notAllowedEmployeeValue)}',topMargin: 2,width: 40,boxFit: BoxFit.fitWidth,height: 33,action: widget.employeeChangeCurrentCompanyTap!=null?ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.changeEmployee)}',buttonColor: MyColor.colorPrimary,textSize: 2.0,textColor: MyColor.colorWhite,height: 7.0,width: ScreenSize(context).widthOnly(60),paddingHorizontal: ScreenSize(context).heightOnly(1.2),elevation: 0,weight: FontWeight.w600,onPressed: widget.employeeChangeCurrentCompanyTap! ):null,);
                  }
                }
            )
                :
            widget.withScrollView==true?GetBodyWidgetWithScrollView(body: widget.body,checkForInternet: widget.checkForInternet,paddingHorizontally:widget.paddingHorizontally!):GetBodyWidgetWithOutScrollView(checkForInternet: widget.checkForInternet,body: widget.body,paddingHorizontally:widget.paddingHorizontally)

        ),
        bottomNavigationBar: widget.bottomNavigationBar,
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }
}

class GetPageStarterScaffoldWithOutSliverAppBar extends StatelessWidget {
  final int? screenColor;
  final double? paddingHorizontally;
  final bool? withScrollView;
  final bool? noAppBar;
  final String? title;
  final Widget? appBar;
  final bool? checkForInternet;
  final PreferredSizeWidget? bottomViewOffAppBar;
  final Widget body;
  final bool? setLocationCheck;
  final Widget? flexibleSpace;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  const GetPageStarterScaffoldWithOutSliverAppBar({this.checkForInternet = true,this.setLocationCheck = false,this.noAppBar,this.withScrollView,this.bottomNavigationBar,this.floatingActionButton,this.appBar,this.paddingHorizontally=0,this.bottomViewOffAppBar,this.screenColor,this.flexibleSpace,required this.body,this.title,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(screenColor??MyColor.colorWhite),
      appBar: noAppBar==true?null:AppBar(
        automaticallyImplyLeading: false,
        shadowColor: const Color(MyColor.colorWhite),
          scrolledUnderElevation:0,
        backgroundColor: const Color(MyColor.colorWhite),
        title: appBar??AppBarWidget(title??''),
        //${CallLanguageKeyWords.get(context, LanguageCodes.services)}
        titleSpacing: 0,
        elevation: 0,
        bottom: bottomViewOffAppBar,
        flexibleSpace: flexibleSpace!=null?FlexibleSpaceBar(
          background: flexibleSpace,
        ):null,
      ),
      body: withScrollView==true?GetBodyWidgetWithScrollView(body: body,checkForInternet: checkForInternet,paddingHorizontally:paddingHorizontally!):GetBodyWidgetWithOutScrollView(checkForInternet: checkForInternet,body: body,paddingHorizontally:paddingHorizontally),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,

    );
  }
}

