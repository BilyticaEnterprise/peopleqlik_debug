import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/controllerRepo/organization_bloc_controller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/data/models/organization_chart_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/data/remote/organization_get_api.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/data/repoImpl/organization_chart_handler_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/domain/usecase/organization_chart_usecase.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';
import 'package:peopleqlik_debug/utils/loader_utils/transparent_loader_class.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';

import '../../domain/model/team_member_model.dart';

class OrganizationChartPageBloc extends ExtendedCubit<AppState> with GetTransparentLoader
{
  late OrganizationChartController chartController;
  late OrganizationChartDealerUseCase useCase;


  OrganizationChartPageBloc(super.initialState){
    useCase = OrganizationChartDealerUseCase(repo: OrganizationChartHandlerRepoImpl(apiRepo: OrganizationApiRepoImpl()));

  }

  initializeController(BuildContext context)
  async {

    AppState appState = await useCase.fetchFirstUserOfTeam(context: context);
    if(appState is AppStateDone<GetOrganizationResultSet>)
    {
      _createChartControllerWithInitialData(
          context: context,
          initialList: useCase.createDataForEachPageView(appState.data)
      );

      if(appState.data?.team != null)
      {
        Future.delayed(const Duration(milliseconds: 800),(){
          chartController.addDataToList!(organizationWidgetModel: useCase.createDataForEachPageView(appState.data));
        });
      }
    }
    emit(appState);

  }

  _createChartControllerWithInitialData({required BuildContext context,required OrganizationWidgetModel initialList})
  {
    chartController = OrganizationChartController(
        onRotatePageHorizontalIndex: (int verticalIndex, int widgetIndex, OrganizationWidgetModel model) {
          useCase.callApiAfterDelay(callBack: (){
            fetchTeamMembers(context, verticalIndex, widgetIndex, model);
          });
        },
        onWidgetTapped: (int verticalIndex, int widgetIndex, OrganizationWidgetModel model) {

        },
        onUpTap: (OrganizationWidgetModel model){
          handleTopUserManagerData(context, model);
        },
        initialList: initialList
    );
  }

  fetchTeamMembers(BuildContext context ,int verticalIndex, int widgetIndex, OrganizationWidgetModel model)async
  {
    initLoader();
    chartController.removeListFromIndex!(listIndex: verticalIndex);
    chartController.showDummyView(false);

    EachTeamMemberModel teamMemberModel = model.teamData![widgetIndex].data as EachTeamMemberModel;
    AppState appState = await useCase.fetchTeamMembers(context: context, employeeCode: teamMemberModel.employeeCode!, companyCode: teamMemberModel.companyCode!);
    chartController.hideDummyView(false);

    if(appState is AppStateDone<OrganizationWidgetModel>)
    {
      chartController.addDataToList!(organizationWidgetModel: appState.data!);
    }
    closeLoader();
  }

  void handleTopUserManagerData(BuildContext context, OrganizationWidgetModel model)async {
    if(model.superVisorData != null)
      {
        initLoader();
        chartController.showDummyView(true);
        EachTeamMemberModel teamMemberModel = model.superVisorData?.data as EachTeamMemberModel;
        AppState appState = await useCase.fetchTopUserManager(context: context, employeeCode: teamMemberModel.employeeCode!, companyCode: teamMemberModel.companyCode!);
        chartController.hideDummyView(true);
        if(appState is AppStateDone<OrganizationWidgetModel>)
        {
          chartController.updateDataOnTop!(organizationWidgetModel: appState.data!);
        }
        closeLoader();
      }
    else
      {
        SnackBarDesign.errorSnack('No more supervisor. You are the top of this team');
      }
  }

}