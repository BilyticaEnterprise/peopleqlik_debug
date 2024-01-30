import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/dividers.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';

import '../../../../../domain/models/mobile_info_model.dart';
import '../../../../../utils/name_box.dart';

class MobileListWidget extends StatelessWidget {
  final MobileInfoModel? data;
  const MobileListWidget({this.data,super.key});

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(25));
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ScreenSize(context).heightOnly(2)),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          width: 0.8,
          color: const Color(MyColor.colorGrey7)
        )
      ),
      child: Material(
        borderRadius: borderRadius,
        color: const Color(MyColor.colorWhite),
        child: InkWell(
          borderRadius: borderRadius,
          splashColor: const Color(MyColor.colorGrey0),
          child: Row(
            children: [
              NameBox(text: data?.name?.substring(0,1)??'M',boxColor: MyColor.colorA4,),
              const DividerByWidth(4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data?.name??'SM-A312',
                      style: GetFont.get(
                          context,
                          fontSize: 1.8,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                      ),
                    ),
                    const DividerByHeight(0.4,),
                    Text(
                      data?.version??'Android, Samsung, 13, A33XNSd',
                      style: GetFont.get(
                          context,
                          fontSize: 1.4,
                          fontWeight: FontWeight.w400,
                          color: MyColor.colorBlack
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
