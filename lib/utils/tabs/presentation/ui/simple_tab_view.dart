import 'package:flutter/material.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/fonts.dart';
import '../../domain/model/tab_bar_data.dart';

class SimpleTabView extends StatelessWidget {
  final TabController tabController;
  final List<TabOptionData> list;
  final TabAlignment? tabAlignment;
  final Function(int) onTap;
  const SimpleTabView({required this.tabController,required this.onTap,required this.list,this.tabAlignment,super.key});

  @override
  Widget build(BuildContext context) {
    double labelPaddingRL = MediaQuery.of(context).size.width/100*4.5;
    double labelPaddingTB = MediaQuery.of(context).size.height/100*1;
    return TabBar(
      controller: tabController,
      tabs: list.map((e) => Text(e.title)).toList(),
      labelStyle: GetFont.get(
        context,
        fontSize: 2.0,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GetFont.get(
        context,
        fontSize: 1.8,
        fontWeight: FontWeight.w400,
      ),
      isScrollable: true,
      indicatorColor: const Color(MyColor.colorPrimary),
      unselectedLabelColor: const Color(MyColor.colorBlack),
      labelColor: const Color(MyColor.colorBlack),
      labelPadding: EdgeInsets.fromLTRB(labelPaddingRL, labelPaddingTB, labelPaddingRL, labelPaddingTB),
      padding: EdgeInsets.zero,
      tabAlignment: tabAlignment??TabAlignment.start,
      onTap: onTap,
    );
  }
}
