import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/dividers.dart';
import 'package:peopleqlik_debug/Version2/Modules/MobileBlockingModule/presentation/ui/mobile_register_view/widgets/previous_devices/previous_header_widget.dart';
import 'package:peopleqlik_debug/Version2/utils/States/app_state.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';

import '../../../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../../../UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import '../../../../../../../../src/colors.dart';
import '../../../../../../../../src/fonts.dart';
import '../../../../../../../../src/language_codes.dart';
import '../../../../bloc/get_mobile_info_bloc.dart';
import '../current_device_widgets/current_mobile_widget.dart';
import 'mobile_list_widget.dart';

class ShowMobileList extends StatelessWidget {
  const ShowMobileList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetMobileInfoBloc,AppState>(
      listener: (context,data){},
      builder: (context, data) {
        if(data is AppStateDone)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrentMobileWidget(data: data.data,),
                  const DividerByHeight(4),
                  const PreviousHeaderWidget(),
                  const DividerByHeight(0.6),
                  MobileListView(),
                ],
              ),
            );
          }
        else
          {
            return CircularIndicatorCustomized();
          }
      }
    );
  }
}

class MobileListView extends StatelessWidget {
  const MobileListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(6), ScreenSize(context).heightOnly(2), ScreenSize(context).widthOnly(6), ScreenSize(context).heightOnly(10)),
        itemBuilder: (context,index)
        {
          return MobileListWidget();
        },
        separatorBuilder: (context,index)
        {
          return const DividerByHeight(2);
        },
        itemCount: 2
    );
  }
}
