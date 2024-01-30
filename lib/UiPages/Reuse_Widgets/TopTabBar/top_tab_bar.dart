import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/TopTabBar/tab_view_listener.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/map_indexed.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:provider/provider.dart';

class TopTabBarWidget extends StatelessWidget {
  final List<String> values;
  final int? defaultSelectedIndex;
  final Function(int) callBackIndex;
  const TopTabBarWidget({required this.values,required this.callBackIndex,this.defaultSelectedIndex = 0,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TabViewListener>(
      create: (_) => TabViewListener(list: values,selectedIndex: defaultSelectedIndex),
      builder: (context, snapshot) {
        return Container(
          height: ScreenSize(context).heightOnly( 6.5),
          margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
          width: double.maxFinite,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color(MyColor.colorGrey6)
          ),
          child: Consumer<TabViewListener>(
              builder: (context, dataIs, child) {
                return Row(
                  children: mapIndexed(dataIs.tabViewListList!, (index, data) =>
                    Expanded(
                        child: TabHeader(dataIs.selectedIndex == index?true:false,'${data.name}',
                                (){
                          dataIs.clickedIndex(index);
                          callBackIndex(index);
                        })
                    )).toList()

                );
              }
          ),
        );
      }
    );
  }
}

class TabHeader extends StatelessWidget {
  final String? header;
  final bool selected;
  final void Function() onClick;
  const TabHeader(this.selected,this.header, this.onClick,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selected?GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.all(ScreenSize(context).heightOnly( 0.5)),
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: const Color(MyColor.colorWhite),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 0.0,
                blurRadius: 14,
                offset: const Offset(3.0, 3.0)),
            BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 0.0,
                blurRadius: 14 / 2.0,
                offset: const Offset(3.0, 3.0)),
            BoxShadow(
                color: Colors.grey.shade50,
                spreadRadius: 2.0,
                blurRadius: 14,
                offset: const Offset(0.0, -3.0)),
            BoxShadow(
                color: Colors.grey.shade50,
                spreadRadius: 2.0,
                blurRadius: 14 / 2,
                offset: const Offset(0.0, -3.0)),
          ],
        ),
        child: Center(
          child: Text(
            header??'',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w600,
                fontSize: 1.6,
                color: MyColor.colorBlack
            ),
          ),
        ),
      ),
    ):Container(
      width: double.maxFinite,
      margin: EdgeInsets.all(ScreenSize(context).heightOnly( 0.5)),
      height: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Material(
          color: const Color(MyColor.colorTransparent),
          child: InkWell(
            splashColor: const Color(MyColor.colorGreySecondary),
            onTap: onClick,
            child: Center(
              child: Text(
                header??'',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w500,
                    fontSize: 1.6,
                    color: MyColor.colorBlack
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
