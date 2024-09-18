import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/commonUis/common_container.dart';
import 'package:peopleqlik_debug/utils/icon_view/done_icon.dart';
import 'package:peopleqlik_debug/utils/icon_view/get_icons.dart';

class DocumentFilterListWidget extends StatelessWidget {
  final String name;
  final Function() onTap;
  final bool isSelected;
  const DocumentFilterListWidget({required this.name,required this.onTap,required this.isSelected,super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: GetFont.get(
                  context,
                fontSize: 1.6,
                fontWeight: FontWeight.w400,
                color: MyColor.colorBlack
              ),
            ),
          ),
          DoneIcon(
            isSelected: isSelected,
          ),
        ],
      ),
    );
  }
}
