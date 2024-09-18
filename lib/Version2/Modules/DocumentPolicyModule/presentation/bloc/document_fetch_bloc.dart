import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import 'package:peopleqlik_debug/Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/data/remote/api_client_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/data/model/fetch_document_api_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/data/remote/fetch_document_policy_api_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/data/repoImpl/fetch_document_list_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/domain/usecase/fetch_document_usecase.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentDetailPage/domain/model/document_policy_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/utils/document_constants.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';
import 'package:provider/provider.dart';

class DocumentFetchBloc extends ExtendedCubit<AppState>
{

  late DocumentFetchUseCase useCase;
  late StreamController<AppState> controller;
  StreamSubscription? streamSubscription;
  bool updatePreviousPage = false;

  DocumentFetchBloc(super.initialState,BuildContext context){
    controller = StreamController.broadcast();
    useCase = DocumentFetchUseCase(
        repo: DocumentFetchListRepoImpl(
            controller: controller,
            apiClientRepo: DocumentPolicyFetchApiRepoImpl(),
            fetchDocumentApiModel: FetchDocumentApiModel(companyCode: '${getCurrentEmployee(context).companyCode}', typeID: DocumentPolicyConstants.defaultTypeId)
        )
    );
  }

  EmployeeInfoMapper getCurrentEmployee(BuildContext context)
  {
    return Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }

  void updateFetchDocumentApiModel(BuildContext context,int typeId)
  {
    useCase.updateFetchDocumentApiModel(typeId);
    useCase.startGettingResult(context, AppStateStart());
  }

  void fetchListNotification(BuildContext context) {
    useCase.startGettingResult(context, AppStateStart());
    streamSubscription = controller.stream.listen((event) {
      emit(event);
    });
  }

  void gotToNextDetailPage(BuildContext context,int index) {
    Navigator.pushNamed(context, CurrentPage.documentDetailPage,
        arguments: DocumentPolicyDetailModel(
          documentTitle: useCase.repo.getList()?[index].documentTitle,
          fileName: '${RequestType.documentUrl}${useCase.repo.getList()?[index].fileName}',
          description: useCase.repo.getList()?[index].description,
          typeID: useCase.repo.getList()?[index].typeID,
          documentCode: useCase.repo.getList()?[index].documentCode,
          companyCode: useCase.repo.getList()?[index].companyCode,
          readAcknowledgement: useCase.repo.getList()?[index].readAcknowledgement,
          acknowledgementBody: useCase.repo.getList()?[index].acknowledgementBody,
          typeName: useCase.repo.getList()?[index].typeName,
          canDownload: useCase.repo.getList()?[index].canDownload,
          createdDate: useCase.repo.getList()?[index].createdDate,
          acknowledgement: useCase.repo.getList()?[index].acknowledgement
        )
    ).then((value) {
      if(value != null && value is bool)
        {
          updatePreviousPage = true;
          fetchListNotification(context);
        }
    });
  }

  void updatePreviousPageMethod() {
    updatePreviousPage = true;
  }
}