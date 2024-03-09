import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../../../../../../utils/tabs/domain/model/tab_bar_data.dart';
import '../../utils/options_list.dart';

class ProfileTabPageBloc extends ExtendedCubit
{
  late List<TabOptionData> _profileOptionList;
  late PageController pageController;
  TabController? tabController;

  ProfileTabPageBloc(super.initialState,BuildContext context)
  {
    _profileOptionList = ProfileOptionsList.getOptionList(context);
    pageController = PageController();
  }

  List<TabOptionData> getProfileOptionList() {
    return _profileOptionList;
  }

  void tabTapped(int index) {
    pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void pageUpdate(int index) {
    tabController?.animateTo(index);
  }

}