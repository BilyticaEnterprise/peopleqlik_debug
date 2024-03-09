import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../utils/tabs/presentation/ui/simple_tab_view.dart';
import '../../../listeners/profile_tab_page_bloc.dart';

class ProfileTabView extends StatefulWidget {
  final Function(int) tabIndexTapped;
  const ProfileTabView({required this.tabIndexTapped,super.key});

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabView> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ProfileTabPageBloc profileTabPageBloc = BlocProvider.of<ProfileTabPageBloc>(context,listen: false);
    profileTabPageBloc.tabController ??= TabController(length: profileTabPageBloc.getProfileOptionList().length, vsync: this);
    return SimpleTabView(
      tabController: profileTabPageBloc.tabController!,
      onTap: widget.tabIndexTapped,
      list: profileTabPageBloc.getProfileOptionList(),
    );
  }
}
