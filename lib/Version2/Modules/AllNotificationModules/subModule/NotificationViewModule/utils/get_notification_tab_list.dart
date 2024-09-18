import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/domain/model/notification_view_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/presentation/ui/tabBodyWidget/notification_tab_body_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/utils/tabs/domain/model/tab_bar_data.dart';
import 'package:provider/provider.dart';

class GetNotificationTabList
{
  List<TabOptionData> getTabs(BuildContext context)
  {
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    return List.generate(
        settingsModelListener.settingsResultSet?.notificationTabs?.length??0,
        (index) => TabOptionData<int>(
                title: settingsModelListener.settingsResultSet?.notificationTabs?[index].screenName??'',
                extraData: settingsModelListener.settingsResultSet?.notificationTabs?[index].screenID
            )
    );
  }

  List<Widget> getWidgets(BuildContext context)
  {
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    return List.generate(
        settingsModelListener.settingsResultSet?.notificationTabs?.length??0,
        (index) => NotificationTabBody(
          key: Key('notification$index'),
          notificationViewMapper: NotificationViewMapper(
              screenId: settingsModelListener.settingsResultSet?.notificationTabs?[index].screenID??0
          ),
        )
    );
  }
}