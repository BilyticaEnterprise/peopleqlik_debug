import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TeamGetListeners/team_detail_listener.dart';
import 'package:provider/provider.dart';

import '../../../../../../Version1/Models/TeamModel/get_team_model.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../../configs/fonts.dart';
import '../../../../../../configs/icons.dart';
import '../../../../../../../utils/screen_sizes.dart';

class EmployeeDetailView extends StatefulWidget {
  final TeamDataList? teamDataList;
  const EmployeeDetailView(this.teamDataList, {Key? key}) : super(key: key);

  @override
  State<EmployeeDetailView> createState() => _EmployeeDetailViewState();
}

class _EmployeeDetailViewState extends State<EmployeeDetailView> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TeamDetailListener teamDetailListener = Provider.of<TeamDetailListener>(context,listen: false);
    return Flexible(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.shortestSide>600?3:2 ,
            childAspectRatio: ScreenSize(context).heightOnly(0.12),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          shrinkWrap: true,
         padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(4.6),vertical: ScreenSize(context).heightOnly(1)),
         // padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(4.6),ScreenSize(context).heightOnly(1),ScreenSize(context).widthOnly(4.6),ScreenSize(context).heightOnly(1)),
          physics: const ClampingScrollPhysics(),
          itemCount: teamDetailListener.dataList.length,
          itemBuilder: (context,index){
            return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Container(
                      margin: EdgeInsets.all(ScreenSize(context).widthOnly(2.6)),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        child: Material(
                          color: const Color(MyColor.colorTransparent),
                          child: GridWidgets(teamDetailListener.dataList[index])
                        ),
                      ),
                    ),
                  ),
                )
            );
          }
      ),

    );
  }
}

class GridWidgets extends StatelessWidget {
  final TeamDetail? list;
  const GridWidgets(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize(context).heightOnly( 18),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: const Color(MyColor.colorPrimary).withOpacity(0.05),
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenSize(context).heightOnly( 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Material(
                color: const Color(MyColor.colorGrey6),
                child: Padding(
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.35)),
                    child: SvgPicture.string(
                      list?.icon??SvgPicturesData.code,
                      width: ScreenSize(context).heightOnly( 3.5),
                      height: ScreenSize(context).heightOnly( 3.5),
                      color: const Color(MyColor.colorGrey3),
                    )
                ),

              ),
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 1.5),),
            Flexible(
              child: Text(
                list?.value??'',
                style: GetFont.get(
                  context,
                  fontSize: 1.8,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorBlack,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}