import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import '../../../../../../../../utils/commonUis/common_container.dart';
import '../../../../../../../../utils/screen_sizes.dart';
import '../../../utils/profile_header_value_text.dart';

class ProfileCompensationViewPage extends StatelessWidget {
  final bool? canEdit;
  const ProfileCompensationViewPage({super.key, this.canEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(3)),
      child: CommonContainer(
        child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemBuilder: (context,index){
              return ProfileHeaderValueText(header: 'BASIC', value: '2000 RS',);
            },
            separatorBuilder: (context,index){
              return const DividerByHeight(2);
            },
            itemCount: 3
        ),
      ),
    );
  }
}

