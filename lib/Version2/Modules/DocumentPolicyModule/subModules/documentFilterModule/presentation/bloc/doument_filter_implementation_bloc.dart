import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/data/repoImpl/document_filter_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/domain/model/document_filter_list.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/domain/usecase/repoImpl/doucment_filter_usecase.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/utils/document_constants.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class DocumentFilterImplementationBloc extends ExtendedCubit<AppState>
{
  late DocumentFilterUseCaseRepoImpl useCase;
  DocumentFilterImplementationBloc(super.initialState,{required int defaultSelectedTypeId})
  {
    useCase = DocumentFilterUseCaseRepoImpl(repo: DocumentFilterRepoImpl(defaultTypeId: defaultSelectedTypeId));
  }

  createListWithDefaultSelectedTypeId({required BuildContext context}) async {
     emit(await useCase.createListWithDefaultSelectedIndex(context: context));
  }

  List<DocumentFilterTypeModel>? getList() {
    return useCase.getList();
  }

  int getSelectedIndex() {
    return useCase.getSelectedIndex();
  }

  updateSelectedIndex(int index) {
    emit(AppStateDone(data: useCase.updateSelectedIndex(index)));
  }

  int getSelectedTypeId() {
    return getList()?[getSelectedIndex()].typeID??DocumentPolicyConstants.defaultTypeId;
  }
}