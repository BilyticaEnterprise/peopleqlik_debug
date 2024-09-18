import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../../ModuleSetting/domain/model/settings_model.dart';
import '../../../../bloc/selected_previous_device.dart';
import 'mobile_list_widget.dart';


class MobileListView extends StatelessWidget {
  final List<DeviceList>? deviceList;
  final Function(int)? selectedId;
  final bool enableSelection;
  const MobileListView({this.deviceList,this.selectedId,this.enableSelection = false,super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<SelectedPreviousDeviceList>(create: (_) => SelectedPreviousDeviceList(0,deviceList))
        ],
        builder: (context) {
          SelectedPreviousDeviceList selectedPreviousDeviceList = BlocProvider.of<SelectedPreviousDeviceList>(context,listen: false);
          return BlocConsumer<SelectedPreviousDeviceList,int>(
              listener: (context,dataId){},
              builder: (context, dataId) {
                if(selectedPreviousDeviceList.deviceList!=null&&selectedPreviousDeviceList.deviceList!.isNotEmpty)
                  {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(6), ScreenSize(context).heightOnly(2), ScreenSize(context).widthOnly(6), ScreenSize(context).heightOnly(10)),
                        itemBuilder: (context,index)
                        {
                          return MobileListWidget(
                            data: selectedPreviousDeviceList.deviceList?[index],
                            onTap: enableSelection==true?(id){
                              if(selectedId!=null){
                                selectedId!(id);
                                selectedPreviousDeviceList.selectedId(id);
                              }
                            }:null,
                            selected: selectedPreviousDeviceList.deviceList?[index].iD == dataId,
                          );
                        },
                        separatorBuilder: (context,index)
                        {
                          return const DividerByHeight(2);
                        },
                        itemCount: selectedPreviousDeviceList.deviceList?.length??0
                    );
                  }
                else
                  {
                    return Padding(
                      padding: EdgeInsets.only(top: ScreenSize(context).heightOnly(4)),
                      child: Center(
                        child: Text(
                          CallLanguageKeyWords.get(context, LanguageCodes.currentNoDevice)??'',
                          style: GetFont.get(
                              context,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorBlack,
                            fontSize: 1.6
                          ),
                        ),
                      ),
                    );
                  }
              }
          );
        }
    );
  }
}
