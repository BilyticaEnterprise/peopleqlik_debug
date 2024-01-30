import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TeamModel/get_team_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/src/icons.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../src/pages_name.dart';
import '../../../src/snackbar_design.dart';
import '../../Models/TeamModel/get_employee_leave_balance_mapper.dart';

class TeamDetailListener extends GetChangeNotifier
{
  List<TeamDetail> dataList = List.empty(growable: true);
  List<TeamDetail> actionList = List.empty(growable: true);

  TeamDetailListener(TeamDataList teamDataList,BuildContext context)
  {
    dataList.add(TeamDetail(SvgPicturesData.boss, teamDataList.supervisorName));
    dataList.add(TeamDetail(SvgPicturesData.code, '${CallLanguageKeyWords.get(context, LanguageCodes.employeeCode)} ${teamDataList.oldEmployeeCode??''}'));
    dataList.add(TeamDetail(SvgPicturesData.code, '${CallLanguageKeyWords.get(context, LanguageCodes.companyCode)} ${teamDataList.companyCode??''}'));

    actionList.add(TeamDetail(SvgPicturesData.call, teamDataList.mobileNo));
    actionList.add(TeamDetail(SvgPicturesData.leaveBalance, CallLanguageKeyWords.get(context, LanguageCodes.leaveBalance)));
  }

  Future<void> makeCall(BuildContext context, TeamDataList? teamDataList) async {
    if(teamDataList?.mobileNo!=null && teamDataList!.mobileNo!.isNotEmpty)
    {
      final Uri emailLaunchUri = Uri(
        scheme: 'tel',
        path: teamDataList.mobileNo!,
      );
      if(await canLaunchUrl(Uri.parse(emailLaunchUri.toString()))) {
        launchUrl(Uri.parse(emailLaunchUri.toString()));
      }
      else
      {
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.phoneCallError1)}');
      }
    }
    else
    {
      SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.phoneCallError2)}');
    }
  }

  void onActionTap(int index,BuildContext context, TeamDataList? teamDataList) {

    switch(index)
    {
      case 0:
        makeCall(context,teamDataList);
        break;
      case 1:

        Navigator.pushNamed(context, CurrentPage.leaveBalancePage,arguments: ForBalanceEmployeeInfo(companyCode: teamDataList?.companyCode,employeeCode: teamDataList?.employeeCode));
        break;
      default:
        break;
    }
  }
}
class TeamDetail
{
  String? icon,value;
  TeamDetail(this.icon,this.value);
}

