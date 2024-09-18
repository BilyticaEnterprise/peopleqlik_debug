import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/widgets/floating_action_button_view.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/widgets/tab_and_page_view/profile_page_view.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/widgets/tab_and_page_view/profile_tabView.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/widgets/top_personal_view.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:provider/provider.dart';
import '../../../../../../../Version1/viewModel/LanguageListeners/language_listener.dart';
import '../listeners/floating_action_button_bloc.dart';
import '../listeners/profile_tab_page_bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<FloatingActionButtonBloc>(create: (_) => FloatingActionButtonBloc(1)),
        BlocProvider<ProfileTabPageBloc>(create: (_) => ProfileTabPageBloc(null,context),),
      ],
      builder: (context) {
        return GetPageStarterScaffoldWithOutSliverAppBar(
          noAppBar: true,
            body: SafeArea(
                top: true,
                child: BodyView()),
          floatingActionButton: FloatingActionButtonView()
        );
      }
    );
  }
}

class BodyView extends StatelessWidget {
  const BodyView({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageEnum languageEnum = Provider.of<ChangeLanguage>(context,listen: false).languageEnum;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TopPersonalView(),
          const DividerByHeight(2),
          ProfileTabView(
            tabIndexTapped: (index)
            {
              BlocProvider.of<ProfileTabPageBloc>(context,listen: false).tabTapped(index);
            },
          ),
          ProfilePageView()
        ],
      ),
    );
  }
}
