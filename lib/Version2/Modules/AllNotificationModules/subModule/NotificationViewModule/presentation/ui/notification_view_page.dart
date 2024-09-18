import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationBadge/domain/repo/notification_badge_controller_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/presentation/listener/notification_tabs_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/presentation/ui/tabBodyWidget/notification_tabs.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/utils/get_notification_tab_list.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/custom_pager_view.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class NotificationListViewPage extends StatelessWidget {
  const NotificationListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<NotificationTabPageBloc>(create: (_) => NotificationTabPageBloc(AppStateNothing(),context)),
      ],
      builder: (context) {
        return GetPageStarterScaffoldWithOutSliverAppBar(
            title: '${CallLanguageKeyWords.get(context, LanguageCodes.notificationsAppBar)}',
           bottomViewOffAppBar: PreferredSize(
               preferredSize: Size(double.infinity, ScreenSize(context).heightOnly(6)),
               child: NotificationTabView(tabIndexTapped: (index) {
                 BlocProvider.of<NotificationTabPageBloc>(context,listen: false).tabTapped(index);
               },)
           ),
            body: const _BodyData()
        );
      }
    );
  }
}

class _BodyData extends StatefulWidget {
  const _BodyData({super.key});

  @override
  State<_BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<_BodyData> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NotificationBadgeControllerRepo.instance.writeNotificationReadPref(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pagesList = GetNotificationTabList().getWidgets(context);
    NotificationTabPageBloc profileTabPageBloc = BlocProvider.of<NotificationTabPageBloc>(context,listen: false);
    return PageView.builder(
        controller: profileTabPageBloc.pageController,
        itemBuilder: (BuildContext context, int index) {
          return pagesList[index];
        },
        itemCount: pagesList.length,
        onPageChanged: (index){
          profileTabPageBloc.pageUpdate(index);
        },

    );
  }
}


