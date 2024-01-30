import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import 'package:provider/provider.dart';

import '../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../src/colors.dart';
import '../../../src/hide_keyboard.dart';
import '../../../src/language_codes.dart';
import '../../../src/lottie_string.dart';
import '../../../src/screen_sizes.dart';
import '../Appbars/app_bar.dart';
import '../Buttons/buttons.dart';
import '../ErrorsUi/not_available.dart';
import 'default_screen_bodies.dart';


class GetPageStarterScaffold extends StatelessWidget {
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
  const GetPageStarterScaffold({
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
        backgroundColor: Color(MyColor.colorWhite),
        body: NestedScrollView(
            physics: scrollPhysicsNever==true?NeverScrollableScrollPhysics():null,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                sliverAppBar??(addToolBarHeight==true? SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: pinned??false,
                  floating: pinned==true?false:float??true,
                  snap: pinned==true?false:float??true,
                  backgroundColor: Color(MyColor.colorWhite),
                  title: appBar??AppBarWidget(title??'',action: action,),
                  //${CallLanguageKeyWords.get(context, LanguageCodes.services)}
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
                  backgroundColor: Color(MyColor.colorWhite),
                  title: appBar??AppBarWidget(title??'',action: action,),
                  //${CallLanguageKeyWords.get(context, LanguageCodes.services)}
                  titleSpacing: 0,
                  //toolbarHeight: MediaQuery.of(context).padding.top,
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
class GetPageStarterScaffoldWithOutSliverAppBar extends StatelessWidget {
  final int? screenColor;
  final double? paddingHorizontally;
  final bool? withScrollView;
  final String? title;
  final Widget? appBar;
  final bool? checkForInternet;
  final PreferredSizeWidget? bottom;
  final Widget body;
  final bool? setLocationCheck;
  final Widget? flexibleSpace;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  const GetPageStarterScaffoldWithOutSliverAppBar({this.checkForInternet = true,this.setLocationCheck = false,this.withScrollView,this.bottomNavigationBar,this.floatingActionButton,this.appBar,this.paddingHorizontally=0,this.bottom,this.screenColor,this.flexibleSpace,required this.body,this.title,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(screenColor??MyColor.colorWhite),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(MyColor.colorWhite),
        title: appBar??AppBarWidget(title??''),
        //${CallLanguageKeyWords.get(context, LanguageCodes.services)}
        titleSpacing: 0,
        elevation: 0,
        bottom: bottom,
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

