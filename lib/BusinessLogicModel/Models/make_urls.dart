import 'dart:convert';

import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/Urls/urls.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/company_urls_prefs.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';

import 'AuthModels/company_url_get_model.dart';

class MakeUrls
{
  Future<void> saveUrl() async
  {
    CompanyResultSet companyJson = CompanyResultSet.fromJson(await jsonDecode(await CompanyInfoPrefs().getCompanyInfoPrefs()));
    RequestType.baseUrl = companyJson.instanceAPIURL;
    RequestType.profileUrl = '${companyJson.instanceFileServerURL}${RequestType.profilePicture}';
    RequestType.attachmentsUrl = '${companyJson.instanceFileServerURL}${RequestType.documentNames}';
    RequestType.fileUrl = '${companyJson.instanceFileServerURL}${RequestType.fileName}';
    RequestType.requestUrl = '${companyJson.instanceFileServerURL}${RequestType.requestName}';

    // PrintLogs.printLogs('fileeeeurl ${RequestType.fileUrl}');
  }
}