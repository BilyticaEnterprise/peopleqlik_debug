import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/presentation/bloc/document_filters_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/presentation/ui/document_filter_view_widget.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/bottomSheetUi/bottom_sheet_ui.dart';
import 'package:peopleqlik_debug/utils/default_Screens/bottom_sheet_screens/bottom_sheet_screen.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class FilterIconWidget extends StatelessWidget {
  final Function() onTap;
  const FilterIconWidget({required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    DocumentFiltersTypeIdBloc bloc = BlocProvider.of<DocumentFiltersTypeIdBloc>(context,listen: false);
    return ClipOval(
      child: Material(
        color: const Color(MyColor.colorTransparent),
        child: InkWell(
          splashColor: const Color(MyColor.colorGrey0),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.0)),
            child: BlocConsumer<DocumentFiltersTypeIdBloc,int>(
              listener: (context,currentTypeId){},
                builder: (context,currentTypeId) {
                  return badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -ScreenSize(context).heightOnly( 0.7), end: -ScreenSize(context).heightOnly( 0.7)),
                      badgeStyle: badges.BadgeStyle(
                        shape: badges.BadgeShape.circle,
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.4)),
                        badgeColor: const Color(MyColor.colorPrimary),
                      ),
                      badgeAnimation: const badges.BadgeAnimation.scale(
                        animationDuration: Duration(milliseconds: 80),
                      ),
                      showBadge: bloc.getDefaultTypeId() != currentTypeId?true:false,
                      badgeContent: SvgPicture.string(
                          SvgPicturesData.done,
                          color: const Color(MyColor.colorWhite),
                          width : ScreenSize(context).heightOnly( 1.6)
                      ),
                      child: SvgPicture.string(SvgPicturesData.filter,width: ScreenSize(context).heightOnly( 3.4),height:ScreenSize(context).heightOnly( 3.4),color: const Color(MyColor.colorBlack),)
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}
