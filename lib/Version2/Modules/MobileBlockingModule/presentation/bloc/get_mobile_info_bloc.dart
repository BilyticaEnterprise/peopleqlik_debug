import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/loader_utils/loader_class.dart';
import '../../../ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../ApiModule/domain/model/api_global_model.dart';
import '../../../../../configs/routing/pages_name.dart';
import '../../../../../mainCommon.dart';
import '../../../../../utils/States/app_state.dart';
import '../../../../../utils/bloc_logic_utils/cubit_ingerited.dart';
import '../../domain/models/current_and_previous_mobile_wrapper.dart';
import '../../domain/models/device_add_remove_mapper.dart';
import '../../domain/usecases/all_mobile_info_usecase.dart';

class GetMobileInfoBloc extends ExtendedCubit<AppState> with GetLoader
{
  late AllMobileInfoUseCase useCase;
  DeviceRestricModel? deviceRestrictModel;
  InActiveDevices? inActiveDevices;
  GetMobileInfoBloc(super.initialState)
  {
    deviceRestrictModel = (super.state as AppStateStart).initialData;
    useCase = AllMobileInfoUseCase();
  }

  start()async
  {
    emit(AppStateDone(data: CurrentAndPreviousMobileMapper(currentMobile: await useCase.createCurrentMobileInfo(),previousDeviceList: deviceRestrictModel?.deviceList)));
  }

  deActivateId(int id)
  {
    inActiveDevices = InActiveDevices(iD: '$id');
  }

  sendInActiveCall(BuildContext context)
  {
    if(inActiveDevices==null)
      {
        SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.selectDevicePlease)??'');
      }
    else
      {
        addUpdateMobile(context);
      }
  }

  sendAddUpdateCall(BuildContext context)
  {
    addUpdateMobile(context);
  }

  AddRemoveDeviceMapper createMapper(BuildContext context)
  {
    AddRemoveDeviceMapper addRemoveDeviceMapper = AddRemoveDeviceMapper();
    addRemoveDeviceMapper.userID = Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.headerInfo?.userID;
    addRemoveDeviceMapper.registeredDevice = useCase.getCurrentMobileInfo();
    if(inActiveDevices!=null)
      {
        addRemoveDeviceMapper.inActiveDevices = [inActiveDevices!];
      }
    return addRemoveDeviceMapper;
  }

  addUpdateMobile(BuildContext context)async
  {

    if(useCase.getCurrentMobileInfo() != null)
      {
        initLoader();
        PrintLogs.printLogs('inactivecall ${createMapper(context).toJson()}');
        ApiResponse apiResponse = await UseCaseGetApisUrlCaller().postMobileDeviceAddUpdate(context, createMapper(context).toJson());
        await closeLoader();
        Future.delayed(const Duration(milliseconds: 200),(){
          if(apiResponse.apiStatus == ApiStatus.done)
          {
            GetNavigatorStateContext.navigatorKey.currentState?.pushNamedAndRemoveUntil(CurrentPage.MainBottomBarPage, (route) => false);
          }
          else
          {
            ShowErrorMessage.show(apiResponse);
          }
        });
      }
  }
}