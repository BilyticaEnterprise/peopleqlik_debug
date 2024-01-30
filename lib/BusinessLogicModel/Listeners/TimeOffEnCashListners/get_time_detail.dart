// import 'package:flutter/material.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/get_leave_detail_api.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/get_leave_detail_model.dart';
// import 'package:peopleqlik_debug/src/colors.dart';
// import 'package:peopleqlik_debug/src/pages_name.dart';
// import 'package:peopleqlik_debug/src/snackbar_design.dart';
// import 'package:peopleqlik_debug/src/strings.dart';
//
// class TimeOffDetailListener extends GetChangeNotifier
// {
//   LeaveDetailsResultSet? leaveDetailsResultSet;
//   ApiStatus apiStatus = ApiStatus.nothing;
//   Future? start(BuildContext context,String leaveCode,String companyCode,String employeeCode)
//   async {
//
//     apiStatus = ApiStatus.started;
//     notifyListeners();
//
//     GetLeaveDetailData? leaveDetailData = await GetLeaveDetailApiCall().callApi(context,leaveCode,companyCode,employeeCode);
//     if(leaveDetailData!=null&&leaveDetailData.getLeaveDetailsJson!=null&&leaveDetailData.getLeaveDetailsJson?.isSuccess==true&&leaveDetailData.getLeaveDetailsJson?.resultSet!=null)
//     {
//       leaveDetailsResultSet = leaveDetailData.getLeaveDetailsJson!.resultSet!;
//       apiStatus = ApiStatus.done;
//
//       notifyListeners();
//     }
//     else if(leaveCreateFormData!=null&&leaveCreateFormData.leaveCreateFormJson!=null&&leaveCreateFormData.leaveCreateFormJson?.isSuccess==false)
//     {
//       PrintLogs.print('errrrr e${leaveCreateFormData.code}');
//       leaveCreateFormResultSet = null;
//       if(leaveCreateFormData.leaveCreateFormJson!=null&&leaveCreateFormData.leaveCreateFormJson?.errorMessage!=null)
//       {
//         ScaffoldMessenger?.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,leaveCreateFormData.leaveCreateFormJson!.errorMessage!,color: MyColor.colorRed));
//       }
//       else {
//         ScaffoldMessenger?.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,leaveCreateFormData.message!,color: MyColor.colorRed));
//       }
//       apiStatus = ApiStatus.error;
//       notifyListeners();
//       if(leaveCreateFormData.code == GetVariable.fourZeroOne)
//       {
//         Navigator.pushNamedAndRemoveUntil(context, CurrentPage.CompanyPage, ModalRoute.withName(CurrentPage.LoginPage));
//       }
//     }
//     else
//     {
//
//       PrintLogs.print('tyytyterrrrr ${leaveCreateFormData!.code}');
//       ScaffoldMessenger?.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,leaveCreateFormData.message!,color: MyColor.colorRed));
//       apiStatus = ApiStatus.error;
//       notifyListeners();
//       if(leaveCreateFormData.code == GetVariable.fourZeroOne)
//       {
//         Navigator.pushNamedAndRemoveUntil(context, CurrentPage.CompanyPage, ModalRoute.withName(CurrentPage.LoginPage));
//       }
//     }
//
//   }
// }