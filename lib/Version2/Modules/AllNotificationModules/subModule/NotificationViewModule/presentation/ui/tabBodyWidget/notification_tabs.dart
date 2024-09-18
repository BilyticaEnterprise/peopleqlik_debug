import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/presentation/listener/notification_tabs_bloc.dart';
import 'package:peopleqlik_debug/utils/tabs/presentation/ui/simple_tab_view.dart';

class NotificationTabView extends StatefulWidget {
  final Function(int) tabIndexTapped;
  const NotificationTabView({required this.tabIndexTapped,super.key});

  @override
  State<NotificationTabView> createState() => _NotificationTabViewState();
}

class _NotificationTabViewState extends State<NotificationTabView> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    NotificationTabPageBloc notificationTabPageBloc = BlocProvider.of<NotificationTabPageBloc>(context,listen: false);
    notificationTabPageBloc.tabController ??= TabController(length: notificationTabPageBloc.getNotificationTabsList().length, vsync: this);
    return SimpleTabView(
      tabController: notificationTabPageBloc.tabController!,
      onTap: widget.tabIndexTapped,
      list: notificationTabPageBloc.getNotificationTabsList(),
    );
  }
}