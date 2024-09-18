import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/data/model/document_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/data/model/fetch_document_api_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/domain/repo/fetch_document_api_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/domain/repo/fetch_document_list_repo.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/pagination_logic_utils/pagination_classes_updated.dart';

class DocumentFetchListRepoImpl extends DocumentFetchListRepo with GetPaginationClassesUpdated<ObjDocument>
{

  AppState appState = AppStateNothing();
  late DocumentPolicyFetchApiRepo apiClientRepo;
  FetchDocumentApiModel fetchDocumentApiModel;

  DocumentFetchListRepoImpl({
    required StreamController<AppState> controller,
    required this.apiClientRepo,
    required this.fetchDocumentApiModel
  })
  {
    stateController = controller;
  }

  @override
  fetchListApi(BuildContext context, AppState status) {
    startGettingResult(context,status);
  }

  @override
  List<ObjDocument>? getList() {
    return dataList;
  }

  @override
  bool isReachEnd() {
    return reachedEnd;
  }

  @override
  updateStepNow(bool value, BuildContext context) {
    updateStep(value, context);
  }

  @override
  reachedEndList(bool reached) {
    reachedEndPage(reached);
    stateController.add(appState);

  }

  @override
  resetInitialData() {
    /// This method get called from start method
    dataList ??= List<ObjDocument>.empty(growable: true); /// If list null then create list
    receiveInitialData(dataList,ObjDocument()); /// pass this list to Pagination Mixin class
  }

  @override
  startGettingResult(BuildContext context, AppState status) async {
    resetInitialData();

    appState = status;
    incrementPage(); ///Whenever user hit the api default page number we set is 0. So to increment that page to 1 we call this method. Why? because our every list API start getting list from page number 1 so if this api again get called then it will increment to 1,2,3... ;

    if(appState is AppStateStart)
    {
      resetList();  /// When first time api gets hit we clear our list and set our page number to 0
    }
    stateController.add(appState);

    FetchDocumentApiModel model = fetchDocumentApiModel;
    model.pageNumber = page;
    ApiResponse apiResponse = await apiClientRepo.fetchDocument(context:context, model: model);
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      updatedResponseAtReachedEndList(appState); /// Because when user reached to End of Page we show a empty CARD view then we have to remove that Empty card so we are removing that card here;
      addAllList(apiResponse.data!.resultSet!.dataList!.toList()); /// New data is inserting in list
      appState = AppStateDone();
      stateController.add(AppStateDone(data: dataList));

    }
    else if(apiResponse.apiStatus == ApiStatus.empty&&dataList!=null&&dataList!.isNotEmpty)
    {
      appState = AppStatePagination();
      updatedResponseAtReachedEndList(appState); /// Again removing empty card here as mentioned above
      decrementPage(); /// Because no new data was found so we have to minus the page number
      stateController.add(AppStatePagination(data: dataList));
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      appState = AppStateEmpty();
      updatedResponseAtReachedEndList(appState); /// Again removing empty card here as mentioned above
      makeListNull(); /// But making list null
      stateController.add(AppStateEmpty());
    }
    else
    {
      appState = AppStateError();
      updatedResponseAtReachedEndList(appState); /// Again removing empty card here as mentioned above
      makeListNull(); /// But making list null
      ShowErrorMessage.show(apiResponse);
      stateController.add(AppStateError());

    }
  }

  @override
  updateFetchDocumentApiModel(int typeId) {
    fetchDocumentApiModel.typeID = typeId;
    fetchDocumentApiModel.pageNumber = 0;
  }

}