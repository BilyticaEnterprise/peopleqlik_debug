import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/SubModules/AttendanceSummaryModule/presentation/ui/widgets/attendance_summary_tab_view.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/Default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../../../utils/custom_pager_view.dart';
import '../../../../../../../utils/tabs/presentation/ui/tab_bar.dart';
import '../../utils/attendance_summary_tab_list_getter.dart';
import '../listener/attendance_summary_tab_listener.dart';

class AttendanceSummaryPage extends StatelessWidget {
  const AttendanceSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<AttendanceSummaryTabListener>(create: (_) => AttendanceSummaryTabListener(null,context),)
      ],
      builder: (context) {
        return GetPageStarterScaffoldWithOutSliverAppBar(
          title: CallLanguageKeyWords.get(context, LanguageCodes.attendanceSummary),
          body: _BodyData(),
          bottomViewOffAppBar: PreferredSize(
              preferredSize: Size(double.infinity, ScreenSize(context).heightOnly(6)),
              child: AttendanceSummaryTabView(tabIndexTapped: (index) {
                BlocProvider.of<AttendanceSummaryTabListener>(context,listen: false).tabTapped(index);
              },)
          ),
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
  Widget build(BuildContext context) {
    List<Widget> pagesList = AttendanceSummaryOptions.getProfileOptionPages();
    AttendanceSummaryTabListener profileTabPageBloc = BlocProvider.of<AttendanceSummaryTabListener>(context,listen: false);
    return SingleChildScrollView(
      child: ExpandablePageView(
        controller: profileTabPageBloc.pageController,
        itemBuilder: (BuildContext context, int index) {
          return pagesList[index];
        },
        itemCount: pagesList.length,
        onPageChanged: (index){
          profileTabPageBloc.pageUpdate(index);
        },

      ),
    );
  }
}
