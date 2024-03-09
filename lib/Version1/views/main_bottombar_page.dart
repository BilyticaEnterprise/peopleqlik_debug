import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/sliding_up_panel.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/Announcements/announcement_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/ui/dashboard_main_page.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TeamPages/team_page.dart';
import 'package:peopleqlik_debug/utils/BottomBarUi/src/snake_bar_widget.dart';
import 'package:peopleqlik_debug/utils/BottomBarUi/src/theming/snake_bar_behaviour.dart';
import 'package:peopleqlik_debug/utils/BottomBarUi/src/theming/snake_shape.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/SlidingUpPanels/panel_body.dart';
import 'package:peopleqlik_debug/utils/SlidingUpPanels/panel_header.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Version1/viewModel/BottomPageInitializers/bottom_page_hander.dart';
import '../../Version2/Modules/AccountModule/presentation/ui/account_page.dart';
import '../../utils/Appbars/app_bar_dashboard.dart';
import 'BottomBarPages/RequestApprovalsPage/services_page.dart';

class MainBottomBarPage extends StatefulWidget {
  const MainBottomBarPage({Key? key}) : super(key: key);

  @override
  _MainBottomBarPageState createState() => _MainBottomBarPageState();
}

class _MainBottomBarPageState extends State<MainBottomBarPage> {
  ScrollController? scrollController;
  PanelController? panelController;
  late SnakeBarBehaviour snakeBarStyle;
  late EdgeInsets padding;
  late int _selectedItemPosition;
  late SnakeShape snakeShape;
  late bool showSelectedLabels;
  late bool showUnselectedLabels;
  Color? containerColor;
  Color selectedColor = Color(MyColor.colorBlack);
  late Gradient selectedGradient;
  Color unselectedColor = Colors.blueGrey;
  late Gradient unselectedGradient;
  late List<Color> containerColors;
  var pages;


  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );

  Widget getPage(index)
  {
    try{scrollController?.jumpTo(0.0);
    }catch(e){
      PrintLogs.printLogs(e.toString());
    }
    return pages[index];

  }

  @override
  void initState() {
    panelController = PanelController();
    scrollController = ScrollController();
    pages = [const DashBoardPage(),const TeamPage(),const PaySlipPage(),const AnnouncementPage(),const AccountPage()];
    initBottomBarData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BottomPageHandler>(context,listen: false).initializeAll(context);
    });
    super.initState();
  }
  @override
  void dispose() {
    //OpenVariables.panelController.close();
    scrollController?.dispose();
    super.dispose();
  }

  void initBottomBarData()
  {
    snakeBarStyle = SnakeBarBehaviour.floating;
    padding = const EdgeInsets.all(16);

    _selectedItemPosition = 0;
    snakeShape = SnakeShape.circle;

    showSelectedLabels = false;
    showUnselectedLabels = false;

    selectedGradient =
    const LinearGradient(colors: [Colors.red, Colors.amber]);

    unselectedGradient =
    const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

    containerColors = [
      const Color(0xFFFDE1D7),
      const Color(0xFFE4EDF5),
      const Color(0xFFE7EEED),
      const Color(0xFFF4E4CE),
    ];
  }
  @override
  Widget build(BuildContext context) {
    final titles=[
      '${CallLanguageKeyWords.get(context, LanguageCodes.DashBoard)}'.toUpperCase(),
      '${CallLanguageKeyWords.get(context, LanguageCodes.teamTeamHeader)}'.toUpperCase(),
      '${CallLanguageKeyWords.get(context, LanguageCodes.Services)}'.toUpperCase(),
      '${CallLanguageKeyWords.get(context, LanguageCodes.Announcements)}'.toUpperCase(),
      '${CallLanguageKeyWords.get(context, LanguageCodes.Account)}'.toUpperCase(),
    ];
    Provider.of<SlidingPanelData>(context,listen: false).panelController = panelController;
    return Material(
      child: SlidingUpPanel(
        maxHeight: ScreenSize(context).heightOnly(90),
        minHeight: 0,
        isDraggable: false,
        panelSnapping: true,
        defaultPanelState: PanelState.CLOSED,
        controller: panelController,
        parallaxEnabled: true,
        backdropEnabled: true,
        backdropColor: const Color(MyColor.colorGreySecondary),
        header: PanelHeader(panelController!),
        parallaxOffset: .5,
        panelBuilder: (sc) => DashBoardPanel(sc,panelController),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        body: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            backgroundColor: const Color(MyColor.colorWhite),
          ),
          backgroundColor: const Color(MyColor.colorWhite),
          bottomNavigationBar: SnakeNavigationBar.color(
            locale: Provider.of<ChangeLanguage>(context,listen: true).currentLocale,
            behaviour: snakeBarStyle,
            snakeShape: snakeShape,
            shape: bottomBarShape,
            padding: window.viewPadding.bottom>0?EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 4.6)):EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly( 3),horizontal: ScreenSize(context).widthOnly( 4.6)),

            ///configuration for SnakeNavigationBar.color
            snakeViewColor: selectedColor,
            selectedItemColor: snakeShape == SnakeShape.indicator ? selectedColor : null,
            unselectedItemColor: Colors.blueGrey,
            elevation: 10,
            shadowColor: const Color(MyColor.colorBackgroundLight).withOpacity(0.7),
            backgroundColor: const Color(MyColor.colorBackgroundLight),
            ///configuration for SnakeNavigationBar.gradient
            //snakeViewGradient: selectedGradient,
            //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
            //unselectedItemGradient: unselectedGradient,

            showUnselectedLabels: showUnselectedLabels,
            showSelectedLabels: showSelectedLabels,

            currentIndex: _selectedItemPosition,
            onTap: (index) => setState(() => _selectedItemPosition = index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.workspaces_filled), label: 'Team'),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Payments'),
              BottomNavigationBarItem(icon: Icon(Icons.announcement), label: 'Announcements'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
            ],
          ),
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                Provider.of<SlidingPanelData>(context,listen: false).realContext = context;
                return <Widget>[
                  SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: false,
                      floating: true,
                      backgroundColor: Color(_selectedItemPosition==4?MyColor.colorWhite:MyColor.colorWhite),
                      snap: true,
                      elevation: 0,
                      titleSpacing: 0,
                      title: AppBarWidgetDashBoard(titles[_selectedItemPosition],_selectedItemPosition,profileTap: (){
                        setState(() {
                          _selectedItemPosition = 4;
                        });
                      },),
                  ),
                ];
              },
              body: pages[_selectedItemPosition],
            )
        ),
      ),
    );
  }
}
