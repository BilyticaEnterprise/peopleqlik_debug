import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/domain/model/document_filter_list.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/domain/repo/document_filter_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:provider/provider.dart';

class DocumentFilterRepoImpl extends DocumentFilterRepo
{
  int _defaultSelectedIndex = 0;
  List<DocumentFilterTypeModel>? _documentFilterTypeList;
  late int _defaultTypeId;

  DocumentFilterRepoImpl({required int defaultTypeId})
  {
    PrintLogs.printLogs('defaulasdas $defaultTypeId');
    _defaultTypeId = defaultTypeId;
  }

  @override
  int updateSelectedIndex(int index) {
    _defaultSelectedIndex = index;
    return index;
  }

  @override
  Future<AppState> createListWithDefaultSelectedIndex({required BuildContext context})async {
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    _documentFilterTypeList = List<DocumentFilterTypeModel>.generate(
      settingsModelListener.settingsResultSet?.companyPolicyType?.length??0,
          (index) => DocumentFilterTypeModel(
          typeID: settingsModelListener.settingsResultSet?.companyPolicyType?[index].typeID,
          typeName: settingsModelListener.settingsResultSet?.companyPolicyType?[index].typeName
      ),
    );
    _documentFilterTypeList?.insert(0, DocumentFilterTypeModel(typeID: 0,typeName: CallLanguageKeyWords.get(context, LanguageCodes.allDocumentPolicy)));

    int? currentIndex = _documentFilterTypeList?.indexWhere((element) => element.typeID == _defaultTypeId);
    if(currentIndex == null||currentIndex == -1)
      {
        currentIndex = 0;
      }
    return AppStateDone(data: currentIndex);
  }

  @override
  int getSelectedIndex() {
    return _defaultSelectedIndex;
  }

  @override
  List<DocumentFilterTypeModel>? getList() {
    return _documentFilterTypeList;
  }

}