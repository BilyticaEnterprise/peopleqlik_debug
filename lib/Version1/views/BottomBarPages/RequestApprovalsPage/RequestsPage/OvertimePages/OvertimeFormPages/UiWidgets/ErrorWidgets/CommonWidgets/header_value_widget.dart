import 'package:flutter/material.dart';

import '../../../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../../../configs/fonts.dart';

class HeaderValueWidget extends StatelessWidget {
  final String header,answer;
  const HeaderValueWidget({required this.header,required this.answer,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            header,
            style: GetFont.get(
              context,
              fontSize: 1.5,
              fontWeight: FontWeight.w400,
              color: MyColor.colorBlack,
            ),
          ),
        ),
        Text(
          answer,
          style: GetFont.get(
            context,
            fontSize: 1.5,
            fontWeight: FontWeight.w600,
            color: MyColor.colorBlack,
          ),
        ),
      ],
    );
  }
}
