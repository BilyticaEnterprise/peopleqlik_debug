import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/utils/document_constants.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class DocumentFiltersTypeIdBloc extends ExtendedCubit<int>
{
  DocumentFiltersTypeIdBloc(super.initialState);

  updateSelectedTypeId(int typeId)
  {
    emit(typeId);
  }

  int getDefaultTypeId()
  {
    return DocumentPolicyConstants.defaultTypeId;
  }

  int getCurrentTypeId() {
    return state;
  }
}