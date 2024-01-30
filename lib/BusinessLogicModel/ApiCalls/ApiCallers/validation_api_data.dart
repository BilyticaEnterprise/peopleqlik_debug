import 'package:dio/dio.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/cookie_model.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/strings.dart';

import '../../../mainCommon.dart';
import '../../Listeners/AuthListeners/save_cookie_globally.dart';
import '../../Models/call_setting_data.dart';

class ValidationApiData
{
  onlyBool(ApiResponse apiResponse)
  {
    if(apiResponse.data!=null&&apiResponse.data?.isSuccess == true)
      {
        apiResponse.apiStatus = ApiStatus.done;
        return apiResponse;
      }
    else
      {

        apiResponse.apiStatus = ApiStatus.error;
        apiResponse = checkIfContainerError(apiResponse);
        return apiResponse;
      }
  }
  getCookie(ApiResponse apiResponse,Response? response)
  {
    CookieJson? cookieJson = getCookieClass(response);
    if(cookieJson!=null)
      {
        apiResponse.code = 200;
        apiResponse.apiStatus = ApiStatus.done;
        apiResponse.data = cookieJson;//saving this to global variable to refresh current api calls to add cookie.
        return apiResponse;
      }
    else
      {
        return ApiResponse('Anti Forgery Token Error',401,ApiStatus.unAuthorized,null);
      }

  }
  includeData(ApiResponse apiResponse)
  {
    if(apiResponse.data!=null&&apiResponse.data?.isSuccess == true)
    {
      if(apiResponse.data!=null&&apiResponse.data?.isSuccess == true&&apiResponse.data?.resultSet!=null)
      {
        apiResponse.apiStatus = ApiStatus.done;
        return apiResponse;
      }
      else
      {
        apiResponse.apiStatus = ApiStatus.error;
        apiResponse = checkIfContainerError(apiResponse);
        return apiResponse;
      }
    }
    else
    {
      apiResponse.apiStatus = ApiStatus.error;
      apiResponse = checkIfContainerError(apiResponse);
      return apiResponse;
    }

  }
  includeListData(ApiResponse apiResponse)
  {
    if(apiResponse.data!=null&&apiResponse.data?.isSuccess == true)
    {
      if(apiResponse.data!=null&&apiResponse.data?.isSuccess == true && apiResponse.data?.resultSet!=null && apiResponse.data!.resultSet.isNotEmpty)
      {
        apiResponse.apiStatus = ApiStatus.done;
        return apiResponse;
      }
      else if(apiResponse.data!=null&&apiResponse.data?.isSuccess == true && apiResponse.data?.resultSet!=null && apiResponse.data!.resultSet.isEmpty)
      {
        apiResponse.apiStatus = ApiStatus.empty;
        apiResponse = checkIfContainerError(apiResponse);
        return apiResponse;
      }
      else if(apiResponse.data!=null&&apiResponse.data?.isSuccess == true && apiResponse.data?.resultSet==null)
      {
        apiResponse.apiStatus = ApiStatus.empty;
        apiResponse = checkIfContainerError(apiResponse);
        return apiResponse;
      }
      else
      {
        apiResponse.apiStatus = ApiStatus.error;
        apiResponse = checkIfContainerError(apiResponse);
        return apiResponse;
      }
    }
    else
    {
      apiResponse.apiStatus = ApiStatus.error;
      apiResponse = checkIfContainerError(apiResponse);
      return apiResponse;
    }
  }

  includeEntityData(ApiResponse apiResponse)
  {
    if(apiResponse.data!=null&&apiResponse.data?.objEntity!=null&&apiResponse.data?.objEntity.isSuccess == true)
    {
      apiResponse.apiStatus = ApiStatus.done;
      return apiResponse;
    }
    else
    {
      apiResponse.apiStatus = ApiStatus.error;
      if(apiResponse.data!=null&&apiResponse.data?.objEntity!=null&&apiResponse.data?.objEntity.errorResourceName!=null&&apiResponse.data!?.objEntity.errorResourceName.isNotEmpty)
      {
        apiResponse.message = CallLanguageKeyWords.get(GetNavigatorStateContext.navigatorKey.currentState!.context, apiResponse.data!.objEntity!.errorResourceName!)??'';
      }
      return apiResponse;
    }
  }

  includeListInsideData(ApiResponse apiResponse)
  {
    if(apiResponse.data!=null&&apiResponse.data?.isSuccess == true)
    {
      if(apiResponse.data!=null&&apiResponse.data?.isSuccess == true && apiResponse.data?.resultSet!=null && apiResponse.data?.resultSet.dataList!=null && apiResponse.data!.resultSet!.dataList.isNotEmpty)
      {
        apiResponse.apiStatus = ApiStatus.done;
        return apiResponse;
      }
      else if(apiResponse.data!=null&&apiResponse.data?.isSuccess == true && apiResponse.data?.resultSet!=null && apiResponse.data?.resultSet.dataList!=null && apiResponse.data!.resultSet!.dataList.isEmpty)
      {
        apiResponse.apiStatus = ApiStatus.empty;
        apiResponse = checkIfContainerError(apiResponse);
        return apiResponse;
      }
      else
      {
        apiResponse.apiStatus = ApiStatus.error;
        apiResponse = checkIfContainerError(apiResponse);
        return apiResponse;
      }
    }
    else
    {
      apiResponse.apiStatus = ApiStatus.error;
      apiResponse = checkIfContainerError(apiResponse);
      return apiResponse;
    }
  }
  checkIfContainerError(ApiResponse apiResponse)
  {
    if(apiResponse.data!=null&&apiResponse.data?.errorMessage!=null&&apiResponse.data!.errorMessage.isNotEmpty)
      {
        apiResponse.message = apiResponse.data!.errorMessage;
      }
    else if(apiResponse.data?.message!=null&&apiResponse.data!.message.isNotEmpty)
    {
      if(apiResponse.data!.message == 'OK')
        {
          apiResponse.message = 'Server error';
        }
      else
        {
          apiResponse.message = apiResponse.data!.message;
        }
    }
    else if(apiResponse.message!=null&&apiResponse.message=='OK')
      {
        apiResponse.message = 'Server error';
      }
    return apiResponse;
  }
}