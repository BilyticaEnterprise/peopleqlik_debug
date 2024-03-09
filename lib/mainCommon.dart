import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/attendance_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/attendance_logic_builder.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/attendance_types_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/NotifcationsListeners/announcements_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/request_form_get_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/request_list_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/request_name_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TeamGetListeners/team_get_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/SummaryListeners/get_summary_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveListModule/presentation/listener/time_off_list_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeSheetListener/get_time_sheet_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/Version1/viewModel/sliding_up_panel.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/ui_time_off_clicks.dart';

import 'package:peopleqlik_debug/splash_screen.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:provider/provider.dart';

import 'Version1/viewModel/AuthListeners/save_cookie_globally.dart';
import 'Version1/viewModel/BottomPageInitializers/bottom_page_hander.dart';
import 'Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import 'Version1/viewModel/Payslips/payslip_list_listener.dart';
import 'Version1/viewModel/TimeOffEnCashListners/SummaryListeners/leave_calender_model_listener.dart';
import 'configs/routing/all_page_screens.dart';
import 'package:peopleqlik_debug/utils/UserLocation/get_user_location.dart';
import 'utils/internetConnectionChecker/internet_connection.dart';
import 'Version2/Modules/AccountModule/presentation/listeners/image_get_listener.dart';
import 'Version2/Modules/DashBoardModule/presentation/listeners/timer_update_listener.dart';
import 'Version2/Modules/FCMModule/domain/repo/fcm_payload_dealer_repo.dart';
import 'Version2/Modules/ModuleAppVersion/presentation/bloc/version_checker_bloc.dart';
import 'commonApps/configs/flavor_config.dart';
import 'configs/themes/app_bar_theme.dart';


FlavorConfig? flavorConfigSettings;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> mainCommon(FlavorConfig flavorConfig) async {

  flavorConfigSettings = flavorConfig;

  //HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(
      appBarThemeStyle
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  notificationsSetting();

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
        Provider<BottomPageHandler>(create: (_) => BottomPageHandler()),
        ChangeNotifierProvider<VersionCheckerNotifier>(create: (_) => VersionCheckerNotifier()),
        ChangeNotifierProvider<CheckInternetConnection>(create: (_) => CheckInternetConnection()),
        ChangeNotifierProvider<ChangeLanguage>(create: (_) => ChangeLanguage()),
        ChangeNotifierProvider<SettingsModelListener>(create: (_) => SettingsModelListener()),
        Provider<CheckUserLocation>(create: (_) => CheckUserLocation()),
        ChangeNotifierProvider<PostAttendanceListener>(create: (_) => PostAttendanceListener(),),
        ChangeNotifierProvider<TimerUpdateListener>(create: (_) => TimerUpdateListener()),
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
              ),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.white, /// <--- THIS IS THE COLOR
              ),
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

Future notificationsSetting()
async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    //    macOS: initializationSettingsMacOS
  );

  await flutterLocalNotificationsPlugin?.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotification,
      onDidReceiveBackgroundNotificationResponse: selectNotification
  );
}

Future showNotificationWithSound(String? title,String? body,dynamic payloadData) async {

  final String groupKey = flavorConfigSettings!.groupKey;
  final String groupChannelId = flavorConfigSettings!.groupChannelId;
  final String groupChannelName = flavorConfigSettings!.groupChannelName;

  final AndroidNotificationDetails firstNotificationAndroidSpecifics =
  AndroidNotificationDetails(
      groupChannelId,
      groupChannelName,
      importance: Importance.max,
      priority: Priority.high,
      channelShowBadge: true,
      playSound: true,
      styleInformation: BigTextStyleInformation(''),
      sound: RawResourceAndroidNotificationSound('ping_1'),
      groupKey: groupKey);
  //IOSNotificationDetails();
  final NotificationDetails firstNotificationPlatformSpecifics = NotificationDetails(android: firstNotificationAndroidSpecifics);
  if(Platform.isAndroid)
  {
    //print('notificajsad $title');
    await flutterLocalNotificationsPlugin?.show(
        1, title, body, firstNotificationPlatformSpecifics,
        payload: '${payloadData['payload']}');
  }
  else{
    await flutterLocalNotificationsPlugin?.show(
        0, title, body, firstNotificationPlatformSpecifics,
        payload: '${payloadData['payload']}');
  }
}


void selectNotification(NotificationResponse? payloadIs)async {
  await flutterLocalNotificationsPlugin?.cancelAll();
  if(payloadIs!=null&&payloadIs.payload!=null&&payloadIs.payload!.isNotEmpty)
  {
    var model = await jsonDecode(payloadIs.payload!);
    FcmPayloadDealerRepo.instance.onSelectedNotification(model);
    print('modelasndasbselect $model');
  }
}

void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {

}
