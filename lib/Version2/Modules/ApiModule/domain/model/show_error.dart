
import '../../../../../mainCommon.dart';
import '../../../../../utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import '../../../../../Version1/viewModel/AuthListeners/log_out_listener.dart';
import 'api_global_model.dart';

class ShowErrorMessage
{
  static show(ApiResponse apiResponse)
  {
    Future.delayed(
        const Duration(milliseconds: 150),
            (){
          if(apiResponse.message!=null&&apiResponse.message!.isNotEmpty&&apiResponse.message!='OK')
          {
            //Vibrator.errorVibrate();
            SnackBarDesign.errorSnack(apiResponse.message??'Unknown Error');
          }
          if(apiResponse.apiStatus == ApiStatus.unAuthorized)
          {
            Future.delayed(const Duration(milliseconds: 50),(){
              MoveOnLoginPage.move(GetNavigatorStateContext.navigatorKey.currentState!.context);
            });
          }
        }
    );
  }
}