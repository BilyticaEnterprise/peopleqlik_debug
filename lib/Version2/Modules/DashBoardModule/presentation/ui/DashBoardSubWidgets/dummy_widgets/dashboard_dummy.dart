import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/ui/DashBoardSubWidgets/dummy_widgets/dummy_dashboard_widget.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/headers/header_large.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../dashboard_main_page.dart';

class DashboardDummy extends StatelessWidget {
  const DashboardDummy({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Skeletonizer(
                child: TopWidget(),
              ),
              Skeletonizer(
                  child: MainHeaderWidget(text: CallLanguageKeyWords.get(context, LanguageCodes.activity)??'')
              ),
              const DummyDashboardWidget(),
              const DummyDashboardWidget(),
            ],
          ),
        )
      ],
    );
  }
}
