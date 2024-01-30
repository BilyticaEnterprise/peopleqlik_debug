import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/enums.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/UiPages/SettingPages/setting_page.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:provider/provider.dart';

import '../../Version2/Modules/MobileBlockingModule/presentation/ui/mobile_blocking_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyData();
  }
}
class BodyData extends StatefulWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SettingsModelListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModelListener>(
      builder: (context, data, child) {
        if(data.settingPageType == SettingPageType.mobileBlocking)
          {
            return MobileBlockingPage();
          }
        else
          {
            return SettingUi();
          }
      }
    );
  }
}

