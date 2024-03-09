import 'package:flutter/material.dart';

import '../../../../../../configs/colors.dart';
import '../../../../../../configs/fonts.dart';

class ProfileHeaderValueText extends StatelessWidget {
  final String header;
  final String value;
  const ProfileHeaderValueText({required this.header,required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            header,
            style: GetFont.get(
                context,
                fontSize: 1.6,
                fontWeight: FontWeight.w400,
                color: MyColor.colorBlack
            ),
          ),
        ),
        Text(
          value,
          style: GetFont.get(
              context,
              fontSize: 1.6,
              fontWeight: FontWeight.w700,
              color: MyColor.colorBlack
          ),
        )
      ],
    );
  }
}
