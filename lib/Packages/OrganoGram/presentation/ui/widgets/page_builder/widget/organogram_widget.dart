import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/organization_current_page_widget_index_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/domain/model/team_member_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/image_getter/cache_image.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:badges/badges.dart' as badges;

class OrganizationChartWidget extends StatelessWidget {
  final DataType? data;
  final int pageIndex;
  final int listIndex;
  final Function() onTap;
  const OrganizationChartWidget({required this.data, required this.pageIndex, required this.listIndex, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    OrganizationCurrentWidgetIndex organizationCurrentWidgetIndex = BlocProvider.of<OrganizationCurrentWidgetIndex>(context,listen: false);
    return BlocConsumer<OrganizationCurrentWidgetIndex,List<int>>(
        listener: (context,data){},
        builder: (context, as) {
          return badges.Badge(
            position: badges.BadgePosition.topEnd(top: ScreenSize(context).heightOnly(2.0), end: ScreenSize(context).heightOnly(1.8)),
            badgeStyle: badges.BadgeStyle(
              shape: badges.BadgeShape.circle,
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.4)),
              badgeColor: const Color(MyColor.colorDarkBrown),
            ),
            badgeAnimation: const badges.BadgeAnimation.scale(
              animationDuration: Duration(milliseconds: 80),
            ),
            showBadge: true,
            badgeContent: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
              child: Text(
                '${data?.data?.totalGloballyUnderEmployees??0}',
                style: GetFont.get(
                    context,
                  fontWeight: FontWeight.w600,
                  fontSize: 1.2,
                  color: MyColor.colorWhite
                ),
              ),
            ),
            child: GetNetWorkImage(
              image: data?.data?.picture??'',
              edgeInsets: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
              boxShape: BoxShape.circle,
              borderPadding: organizationCurrentWidgetIndex.getCurrentFocusedIndexAt(listIndex)==pageIndex?0.2:0.4,
              withBorder: true,
              borderColor: organizationCurrentWidgetIndex.getCurrentFocusedIndexAt(listIndex)==pageIndex?MyColor.colorPrimary:MyColor.colorGrey0,
              borderWidth: 2,
              boxFit: BoxFit.contain,
           //   onTap: organizationCurrentWidgetIndex.getCurrentFocusedIndexAt(listIndex)==pageIndex?onTap:null,
            ),
          );

        }
    );

  }
}


// Align(
// alignment: Alignment.topRight,
// child: Container(
// margin: EdgeInsets.only(top: ScreenSize(context).heightOnly(2),right: ScreenSize(context).heightOnly(2)),
// decoration: const BoxDecoration(
// shape: BoxShape.circle,
// color: Color(MyColor.colorDarkBrown),
// ),
// child: Padding(
// padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.7)),
// child: Text(
// '1',
// style: GetFont.get(
// context,
// color: MyColor.colorWhite,
// fontSize: 1.2,
// fontWeight: FontWeight.w600
// ),
// ),
// ),
// ),
// )