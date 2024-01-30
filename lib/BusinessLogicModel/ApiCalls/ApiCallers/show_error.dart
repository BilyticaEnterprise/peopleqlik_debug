
import '../../../mainCommon.dart';
import '../../../src/snackbar_design.dart';
import '../../Enums/apistatus_enum.dart';
import '../../Listeners/AuthListeners/log_out_listener.dart';
import '../ApiGlobalModel/api_global_model.dart';

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