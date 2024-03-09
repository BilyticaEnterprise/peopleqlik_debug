import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/custom_pager_view.dart';

import '../../../../utils/options_list.dart';
import '../../../listeners/profile_tab_page_bloc.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pagesList = ProfileOptionsList.getProfileOptionPages(canEdit: true);
    ProfileTabPageBloc profileTabPageBloc = BlocProvider.of<ProfileTabPageBloc>(context,listen: false);
    return ExpandablePageView(
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
