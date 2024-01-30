import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/AttendanceListener/attendance_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/AttendanceListener/attendance_logic_builder.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/AttendanceListener/attendance_types_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/NotifcationsListeners/announcements_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_form_get_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/request_name_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TeamGetListeners/team_get_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/SummaryListeners/get_summary_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/time_off_list_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeSheetListener/get_time_sheet_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/sliding_up_panel.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/ui_time_off_clicks.dart';
import 'package:peopleqlik_debug/UiPages/SettingPages/settings.dart';

import 'package:peopleqlik_debug/splash_screen.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:provider/provider.dart';

import 'BusinessLogicModel/Listeners/Accounts/image_get_listener.dart';
import 'BusinessLogicModel/Listeners/Approvals/approvals_collector.dart';
import 'BusinessLogicModel/Listeners/AuthListeners/save_cookie_globally.dart';
import 'BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import 'BusinessLogicModel/Listeners/Payslips/payslip_list_listener.dart';
import 'BusinessLogicModel/Listeners/TimeOffEnCashListners/SummaryListeners/leave_calender_model_listener.dart';
import 'BusinessLogicModel/Listeners/TimeOffEnCashListners/time_off_add_edit_attachments_collector.dart';
import 'BusinessLogicModel/Listeners/all_page_screens.dart';
import 'BusinessLogicModel/UserLocation/get_user_location.dart';
import 'BusinessLogicModel/internet_connection.dart';
import 'commonApps/configs/flavor_config.dart';
import 'configs/themes/app_bar_theme.dart';


FlavorConfig? flavorConfigSettings;
Future<void> mainCommon(FlavorConfig flavorConfig) async {
  flavorConfigSettings = flavorConfig;

  //HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(
      appBarThemeStyle
  );
  WidgetsFlutterBinding.ensureInitialized();
  //notificationsSetting();
  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        Provider<SaveCookieGlobally>(create: (_) => SaveCookieGlobally()),
        ChangeNotifierProvider<CheckInternetConnection>(create: (_) => CheckInternetConnection()),
        ChangeNotifierProvider<ChangeLanguage>(create: (_) => ChangeLanguage()),
        ChangeNotifierProvider<SettingsModelListener>(create: (_) => SettingsModelListener()),
        Provider<CheckUserLocation>(create: (_) => CheckUserLocation()),
        ChangeNotifierProvider<PostAttendanceListener>(create: (_) => PostAttendanceListener(),),
        ChangeNotifierProvider<AttendanceLogicBuilder>(create: (_) => AttendanceLogicBuilder(),),
        ChangeNotifierProvider<AttendanceTypesCollector>(create: (_) => AttendanceTypesCollector(),),
        ChangeNotifierProvider<LeaveCalenderModelListener>(create: (_) => LeaveCalenderModelListener()),
        ChangeNotifierProvider<SlidingPanelData>(create: (_) => SlidingPanelData()),
        ChangeNotifierProvider<TimeOffCurrentPage>(create: (_) => TimeOffCurrentPage()),
        ChangeNotifierProvider<TimeOffModelListener>(create: (_) => TimeOffModelListener()),
        ChangeNotifierProvider<LeaveSummaryModelListener>(create: (_) => LeaveSummaryModelListener(),),
        ChangeNotifierProvider<GetImage>(create: (_) => GetImage()),
        ChangeNotifierProvider<GetRequestNameListener>(create: (_) => GetRequestNameListener()),
        ChangeNotifierProvider<GetRequestListListener>(create: (_) => GetRequestListListener()),
        ChangeNotifierProvider<GetTeamListModelListener>(create: (_) => GetTeamListModelListener()),
        ChangeNotifierProvider<GetRequestFormListener>(create: (_) => GetRequestFormListener()),
        ChangeNotifierProvider<PayslipListModelListener>(create: (_) => PayslipListModelListener()),
        ChangeNotifierProvider<GetAnnouncementModelListener>(create: (_) => GetAnnouncementModelListener()),
        ChangeNotifierProvider<GetTimeSheetListener>(create: (_) => GetTimeSheetListener()),
        ChangeNotifierProvider<GlobalSelectedEmployeeController>(create: (_) => GlobalSelectedEmployeeController())
      ],
      child: Builder(
        builder: (context) {
          return Consumer<ChangeLanguage>(
            builder: (context,data,child) {
              return AfterLocale(data);
            }
          );
        }
      ),
    );
  }
}

class AfterLocale extends StatefulWidget {
  final ChangeLanguage data;
  const AfterLocale(this.data, {Key? key}) : super(key: key);

  @override
  _AfterLocaleState createState() => _AfterLocaleState();
}

class _AfterLocaleState extends State<AfterLocale> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChangeLanguage>(context,listen: false).setInitialLanguage();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

        return MaterialApp(
            navigatorKey: GetNavigatorStateContext.navigatorKey,
            scaffoldMessengerKey: GetNavigatorStateContext.rootScaffoldMessengerKey,
            title: flavorConfigSettings?.appTitle??'PeopleQlik',
            theme: ThemeData(
                primarySwatch: Colors.green,
                primaryColor: const Color(MyColor.colorPrimary),
              appBarTheme: AppBarTheme(
                systemOverlayStyle: appBarThemeStyle
              )
            ),
            debugShowCheckedModeBanner: false,
            supportedLocales: const [
              Locale('en','US'),Locale('en','PK'),Locale('ar','PK'),Locale('ar','SA'),Locale('ar','EG'),Locale('ar','EG'),Locale('ar','DZ'),Locale('ar','BH')
              ,Locale('ar','IQ'),Locale('ar','JO'),Locale('ar','KW'),Locale('ar','LB'),Locale('ar','OM'),Locale('ar','QA')
            ],
            localizationsDelegates: const [
              // ... app-specific localization delegate[s] here
              LanguageLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocale,supportedLocals){
              for(var locale in supportedLocals){
                if(locale.languageCode==deviceLocale?.languageCode&&locale.countryCode==deviceLocale?.countryCode)
                {
                  return deviceLocale;
                }
              }
              return supportedLocals.first;
            },
            locale: widget.data.currentLocale,
            initialRoute: '/',
            routes: getScreens()
        );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SplashScreen();
  }
}
class GetNavigatorStateContext {
  static GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
