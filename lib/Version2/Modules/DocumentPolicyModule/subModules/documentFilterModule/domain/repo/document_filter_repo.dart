import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/domain/model/document_filter_list.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class DocumentFilterRepo
{
  Future<AppState> createListWithDefaultSelectedIndex({required BuildContext context});
  int updateSelectedIndex(int index);
  int getSelectedIndex();
  List<DocumentFilterTypeModel>? getList();
}