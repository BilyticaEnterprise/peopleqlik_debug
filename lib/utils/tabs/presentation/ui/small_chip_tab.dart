import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/fonts.dart';
import '../../../screen_sizes.dart';
import '../../domain/model/tab_chip_detail.dart';
import '../listener/small_chip_listener.dart';

class SmallChipTab<T> extends StatelessWidget {
  final List<TabChipDetail> tabList;
  T defaultSelectedEnum;
  double? tabHeight;
  SmallChipTab({required this.tabList,required this.defaultSelectedEnum,this.tabHeight,super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<SmallChipListener>(create: (_) => SmallChipListener(defaultSelectedEnum),)
      ],
      builder: (context) {
        return BlocConsumer<SmallChipListener,dynamic>(
          listener: (context,data){},
          builder: (context, data) {
            return SizedBox(
              height: ScreenSize(context).heightOnly(3.8),
              child: ListView.separated(
                shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return _SmallChipTabWidget(
                      text: tabList[index].text,
                      selected: tabList[index].tabType == data,
                      onTap: (){BlocProvider.of<SmallChipListener>(context).selectedIndex(tabList[index].tabType);},
                    );
                  },
                  separatorBuilder: (context,index){
                    return const DividerByWidth(2);
                  },
                  itemCount: tabList.length
              ),
            );
          }
        );
      }
    );
  }
}

class _SmallChipTabWidget extends StatelessWidget {
  final String text;
  final bool selected;
  final Function() onTap;
  const _SmallChipTabWidget({required this.text,required this.selected,required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    double broderRadius = 25;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(broderRadius)),
            color: Color(selected == true?MyColor.colorPrimary:MyColor.colorTransparent),
            border: Border.all(
              width: 1,
              color: Color(selected == true?MyColor.colorPrimary:MyColor.colorGrey0),
            )
        ),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(broderRadius)),
          color: Color(selected == true?MyColor.colorPrimary:MyColor.colorTransparent),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(broderRadius)),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(3),),
              child: Center(
                child: Text(
                  text,
                  style: GetFont.get(
                      context,
                      fontSize: 1.4,
                      fontWeight: FontWeight.w400,
                      color: selected == true?MyColor.colorWhite:MyColor.colorGrey3
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
