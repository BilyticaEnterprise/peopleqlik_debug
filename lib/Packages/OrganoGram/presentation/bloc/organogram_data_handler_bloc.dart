import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/data/repoImpl/organization_chart_handler_repo_impl.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organization_chart_handler_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/repo/organogram_states.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/usecase/organization_chart_usecase.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/organization_current_page_widget_index_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/organization_swiper_handler_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/controllerRepo/organization_bloc_controller.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class OrganizationChartBloc extends ExtendedCubit<List<OrganizationChartHandlerModel>>
{
  OrganizationChartController blocController;
  late OrganizationChartUseCase useCase;
  bool uiCreated = false;
  late BuildContext context;
  late StreamSubscription<List<OrganizationChartHandlerModel>> dataController;

  OrganizationChartBloc(super.initialState,{required this.blocController}){
    StreamController<List<OrganizationChartHandlerModel>> streamController = StreamController<List<OrganizationChartHandlerModel>>.broadcast();
    setListListener(streamController);
    useCase = OrganizationChartUseCase(repo: OrganizationChartHandlerRepoImpl(streamController: streamController,initialList: blocController.initialList));
    blocController.showDummyView = useCase.showDummyView;
    blocController.hideDummyView = useCase.hideDummyView;
    blocController.addDataToList = useCase.addDataToList;
    blocController.updateDataOnTop = useCase.updateDataOnTop;
    blocController.isDummyVisible = useCase.isDummyVisible;
    blocController.removeListFromIndex = useCase.removeListFromIndex;
    // blocController.enableInteractionTo = enableInteractionTo;
  }

  seContext(BuildContext context)
  {
    this.context = context;
  }

  setListListener(StreamController<List<OrganizationChartHandlerModel>> streamController)
  {
    dataController = streamController.stream.listen((event) async {
      uiCreated = true;
      await BlocProvider.of<OrganizationSwiperHandlerBloc>(context,listen: false).updateListForScrolling(event);
      await BlocProvider.of<OrganizationCurrentWidgetIndex>(context,listen: false).updateListForIndexes(event);

      Future.delayed(const Duration(milliseconds: 200),(){
        emit(List<OrganizationChartHandlerModel>.generate(event.length, (index) => event[index]));
      });
    });
  }

  @override
  Future<void> close() {
    dataController.cancel();
    return super.close();
  }

  void widgetTapped(int listIndex, int widgetIndex, OrganizationWidgetModel dataState) {
    blocController.onWidgetTapped(listIndex,widgetIndex, dataState);
  }

  void currentRotateVerticalHorizontalIndex(int listIndex, int widgetIndex, OrganizationWidgetModel dataModel) {
    useCase.currentRotatePageHorizontalIndex(listIndex, widgetIndex);
    blocController.onRotatePageHorizontalIndex(listIndex,widgetIndex,dataModel);
  }

  void onUpTap() {
    if(state.first.organizationChartData is OrganizationChartDataState)
      {
        blocController.onUpTap!((state.first.organizationChartData as OrganizationChartDataState).data as OrganizationWidgetModel);
      }
  }

  // Future<void> enableInteractionTo({required bool enable})async{
  //   BlocProvider.of<OrganizationSwiperHandlerBloc>(context,listen: false).updateScrollingPermissionList(enable);
  //   //BlocProvider.of<OrganizationChartBloc>(context,listen: false).updateScrollingAt(widget.listIndex);
  //
  // }

  void updateScrollingAt(int listIndex) {
    state[listIndex].allowScrolling = true;
    useCase.updateScrollingPermissionAt(listIndex);
  }

}