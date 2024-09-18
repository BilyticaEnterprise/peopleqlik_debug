import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/lines_widget/horizontal_vertical_line.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../configs/colors.dart';
import '../bloc/notification_permission_bloc.dart';

class NotificationPermissionSettings extends StatelessWidget {
  const NotificationPermissionSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<NotificationGetBloc>(create: (_) => NotificationGetBloc(true))
      ],
      builder: (context) {
        return GetPageStarterScaffoldStateLess(
         // title: CallLanguageKeyWords.get(context, LanguageCodes.notificationPermissionHeader),
          body: BodyData(),
        );
      }
    );
  }
}
class BodyData extends StatefulWidget {
  const BodyData({super.key});

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<NotificationGetBloc>(context,listen: false).getNotificationStatusOnline(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    NotificationGetBloc notificationGetBloc = BlocProvider.of<NotificationGetBloc>(context,listen: false);
    return BlocConsumer<NotificationGetBloc,bool>(
      listener: (context,data){},
      builder: (context, data) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DividerByHeight(1),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      CallLanguageKeyWords.get(context, LanguageCodes.allowPermission)??'',
                      style: GetFont.get(
                          context,
                        fontSize: 2.2,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorBlack
                      ),
                    ),
                  ),
                  Switch(
                      value: data,
                      activeColor: const Color(MyColor.colorPrimary).withOpacity(0.8),
                      activeTrackColor: const Color(MyColor.colorGrey0),
                      inactiveTrackColor: const Color(MyColor.colorGrey0),
                      //trackOutlineColor: Color(MyColor.colorGrey0),
                      onChanged: (status){
                        notificationGetBloc.updateNotificationMapper(status);
                        notificationGetBloc.updateNotificationStatusOnline(context);
                      }
                  )
                ],
              ),
              HorizontalLine(),
            ],
          ),
        );
      }
    );
  }
}
