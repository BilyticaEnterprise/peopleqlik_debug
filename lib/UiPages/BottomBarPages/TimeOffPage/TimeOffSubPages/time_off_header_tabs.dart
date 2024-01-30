import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';

class TimeOffHeader extends StatelessWidget {
  final String? header;
  final bool selected;
  final void Function() onClick;
  const TimeOffHeader(this.selected,this.header, this.onClick,{Key? key}) : super(key: key);

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
