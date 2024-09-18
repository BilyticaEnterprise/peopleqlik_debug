import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/ui/organogram_widget_builder.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/presentation/bloc/organization_chart_page_bloc.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/utils/lottie_anims_utils/lottie_string.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';

class OrganizationChartPage extends StatelessWidget {
  const OrganizationChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<OrganizationChartPageBloc>(create: (_) => OrganizationChartPageBloc(AppStateNothing()))
      ],
      builder: (context) {
        return GetPageStarterScaffoldStateLess(
          title: '${CallLanguageKeyWords.get(context, LanguageCodes.organizationChart)}',
          body: _BodyData(),
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
    BlocProvider.of<OrganizationChartPageBloc>(context,listen: false).initializeController(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    OrganizationChartPageBloc organizationChartPageBloc = BlocProvider.of<OrganizationChartPageBloc>(context,listen: false);
    return BlocConsumer<OrganizationChartPageBloc,AppState>(
      listener: (context, data){},
      builder: (context, data) {
        if(data is AppStateDone || data is AppStateEmpty)
          {
            return OrganizationChartWidgetBuilder(
              organizationChartController: organizationChartPageBloc.chartController,
            );
          }
        else if(data is AppStateError)
        {
          return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
        }
        else
        {
          return const CircularIndicatorCustomized();
        }
      }
    );
  }
}
