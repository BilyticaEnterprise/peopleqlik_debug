import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organization_chart_handler_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/repo/organogram_states.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/organization_current_page_widget_index_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/organogram_data_handler_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/domain/model/team_member_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';

class NamesTextViewsBuilder extends StatelessWidget {
  final int listIndex;
  const NamesTextViewsBuilder({required this.listIndex,super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationChartBloc,List<OrganizationChartHandlerModel>>(
        listener: (context, data){},
        builder: (context, data) {
          print('sadasdas ${data[listIndex].organizationChartData}');
          if(data[listIndex].organizationChartData is OrganizationChartDataState)
          {
            return _BodyData(data: data[listIndex].organizationChartData as OrganizationChartDataState, listIndex: listIndex,);
            }
          else
            {
              return Container(height: 0,);
            }
      }
    );
  }
}

class _BodyData extends StatelessWidget {
  final OrganizationChartDataState data;
  final int listIndex;
  const _BodyData({required this.data, required this.listIndex,super.key});

  @override
  Widget build(BuildContext context) {
    OrganizationCurrentWidgetIndex organizationCurrentWidgetIndex = BlocProvider.of<OrganizationCurrentWidgetIndex>(context,listen: false);
    return BlocConsumer<OrganizationCurrentWidgetIndex,List<int>>(
        listener: (context,data){},
        builder: (context, da) {

          OrganizationWidgetModel organizationWidgetModel = data.data as OrganizationWidgetModel;
          String name = '';
          String designation = '';
          if(listIndex == 0)
            {
              name = (organizationWidgetModel.currentUserData?.data as EachTeamMemberModel).name??'';
              designation = (organizationWidgetModel.currentUserData?.data as EachTeamMemberModel).designation??'';
            }
          else
            {
              name = (organizationWidgetModel.teamData?[organizationCurrentWidgetIndex.getCurrentFocusedIndexAt(listIndex)].data as EachTeamMemberModel).name??'';
              designation = (organizationWidgetModel.teamData?[organizationCurrentWidgetIndex.getCurrentFocusedIndexAt(listIndex)].data as EachTeamMemberModel).designation??'';
            }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: GetFont.get(
                  context,
                  fontSize: 1.6,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack,
                ),
                textAlign: TextAlign.center,
              ),
              const DividerByHeight(0.2),
              Text(
                designation,
                style: GetFont.get(
                    context,
                    fontSize: 1.4,
                    fontWeight: FontWeight.w400,
                    color: MyColor.colorGrey3
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }
    );
  }
}
