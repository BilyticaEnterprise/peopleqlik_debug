import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/domain/model/document_filter_list.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/domain/repo/document_filter_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/domain/usecase/repo/document_filter_usecase_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class DocumentFilterUseCaseRepoImpl extends DocumentFilterUseCaseRepo
{
  DocumentFilterRepo repo;
  DocumentFilterUseCaseRepoImpl({required this.repo});

  @override
  Future<AppState> createListWithDefaultSelectedIndex({required BuildContext context}) async {
    return await repo.createListWithDefaultSelectedIndex(context: context);
  }

  @override
  List<DocumentFilterTypeModel>? getList() {
    return repo.getList();
  }

  @override
  int getSelectedIndex() {
    return repo.getSelectedIndex();
  }

  @override
  int updateSelectedIndex(int index) {
    return repo.updateSelectedIndex(index);
  }
}