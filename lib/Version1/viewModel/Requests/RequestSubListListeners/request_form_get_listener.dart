import 'dart:convert';

import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/Version1/viewModel/Requests/save_request_form_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/time_off_add_edit_attachments_collector.dart';
import 'package:peopleqlik_debug/Version1/models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/Version1/models/PaysSlipApprovalsRequest/request_list_form_model.dart';
import 'package:peopleqlik_debug/Version1/models/RequestsModel/submit_request_model.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import '../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class GetRequestFormListener extends GetChangeNotifier
{
  GetRequestFormResultSet? requestFormResultSet;
  LoginResultSet? loginResultSet;
  List<GetFileType>? getFiles;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<FormData> formList = List.empty(growable: true);
  var encodedRequest;
  Future? start(BuildContext context,int? requestManagerID)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();
    loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getRequestFormApi(context,'?RequestManagerID=$requestManagerID');

    //GetRequestFormData? getRequestFormData = await GetRequestFormApiCall().callApi(context,id);
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      requestFormResultSet = apiResponse.data!.resultSet;
      encodedRequest = jsonEncode(requestFormResultSet?.toJson());
      await sortDataList(context);
      updateDependents(CallNotify.noNeed,context);
      apiStatus = ApiStatus.done;
      notifyListeners();

    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      apiStatus = ApiStatus.empty;
      if(apiResponse.data!=null&&apiResponse.data?.errorMessage!=null)
      {
        SnackBarDesign.errorSnack(apiResponse.data!.errorMessage);
      }
      requestFormResultSet = null;
      notifyListeners();
    }
    else
    {
      apiStatus = apiResponse.apiStatus!;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }
  Future<void> sortDataList(BuildContext context) async
  {
    /// Here we are doing the real thing a lIST with FORMDATA is created and the purpose of this list is to
    /// store the data for UI creation then populate that UI accordingly
    /// FormData has the following type of data:
    /// 1 = UiType (either its dropdown,text,checkbox etc)
    /// 2 = ReqDetail List (with Optional String added if UiType is dropdown or multiDropdown)
    /// 3 = Encoded ReqDetail List (because of reflection concept bug with Optional String added if UiType is dropdown or multidropdown)
    /// 4 = AdmRequestManagerDt data where we can see either this is dropdown,text,checkbox etc
    /// 5 = Current Index from GetRequestFormResultSet which has 'AdmRequestManagerDt and List<List<ReqDetail>>'
    /// 6 = doUpdate value because provider notify only 'build' method of Stful widget not 'initState' method
    ///     so to update a Widget we call notifylistener and it updates dropdown widget logic
    /// 7 = List<List<ReqDetail>> Index which we get from 'count' variable given below
    /// 8 = selectedIndex variable which accept dropdown selected index by user
    /// 9 = "isEnable" checks that either this widget is enabled or not
    /// 10 = "dependent" checks either this current index AdmRequestManagerDt does have a parent or not
    ///      if it does have a parent then we get his parent index and name and destName

    int count = 0;
    formList.clear();
    for(int x=0;x<requestFormResultSet!.reqMaster!.admRequestManagerDt!.length;x++)
    {
      UiTypes? getType = await getUiType(requestFormResultSet?.reqMaster?.admRequestManagerDt![x].controlTypeID);
      PrintLogs.printLogs('form xxxxx $x $count ${getType}');
      if((requestFormResultSet!.reqMaster!.admRequestManagerDt![x].resultSet!=null&&requestFormResultSet!.reqMaster!.admRequestManagerDt![x].resultSet!.isNotEmpty)&&(getType != UiTypes.checkBox))
      {
        PrintLogs.printLogs('Ui $x $count ${getType}');
        GetRequestFormResultSet requestFormResultSet = GetRequestFormResultSet.fromJson(await jsonDecode(encodedRequest));
        AdmRequestManagerDt? admRequestManagerDt = requestFormResultSet.reqMaster?.admRequestManagerDt?[x];
        formList.add(
            FormData(
                uiTypes: getType,
                data: insertOptionalString(GetRequestFormResultSet.fromJson(await jsonDecode(encodedRequest)).reqDetail?[count],getType,context),
                encodedRequestList: jsonEncode(insertOptionalString(GetRequestFormResultSet.fromJson(await jsonDecode(encodedRequest)).reqDetail?[count], getType,context)),
                admRequestManagerDt: admRequestManagerDt,
                dataIndex: x,
                response: await updateInitialSelected(admRequestManagerDt!,insertOptionalString(GetRequestFormResultSet.fromJson(await jsonDecode(encodedRequest)).reqDetail?[count],getType,context), getType),
                doUpdate: false,
                multiSelected: null,
                reqDetailIndex: count,
                selectedIndex: await getSelectedIndex(admRequestManagerDt,insertOptionalString(GetRequestFormResultSet.fromJson(await jsonDecode(encodedRequest)).reqDetail?[count],getType,context), getType),
                isEnable: filterIsEnable(admRequestManagerDt,requestFormResultSet.reqDetail?[count], getType),
                dependent: filterDependent(admRequestManagerDt, requestFormResultSet.reqMaster),
                changed: false
        )
        );
        count +=1;
      }
      else
      {
        GetRequestFormResultSet requestFormResultSet = GetRequestFormResultSet.fromJson(await jsonDecode(encodedRequest));
        AdmRequestManagerDt? admRequestManagerDt = requestFormResultSet.reqMaster?.admRequestManagerDt?[x];
        formList.add(
            FormData(
                uiTypes: getType,
                data: null,
                encodedRequestList: null,
                doUpdate: false,
                admRequestManagerDt: admRequestManagerDt,
                dataIndex: x,
                reqDetailIndex: -1,
                selectedIndex: -1,
                multiSelected: null,
                isEnable: filterIsEnable(admRequestManagerDt!,null, getType),
                dependent: filterDependent(admRequestManagerDt,requestFormResultSet.reqMaster),
                changed: false
            )
        );
      }
    }
  }
  Future<UiTypes>? getUiType(int? type) async
  {
    /// Here its telling to the UI that what kind of UITYPE is this
    switch (type)
    {
      case 1:
        return UiTypes.textBox;
      case 2:
        return UiTypes.dropDown;
      case 3:
        return UiTypes.checkBox;
      case 5:
        return UiTypes.datePicker;
      case 6:
        return UiTypes.multipleDropDown;
      default:
        return UiTypes.unKnown;

    }
  }
  Future<void>? updateSelectedIndex(RequestCallBack requestCallBack) async
  {
    PrintLogs.printLogs('i selet ${requestCallBack.dataIndex} ${requestCallBack.selectedIndex}');
    formList[requestCallBack.dataIndex!].selectedIndex = requestCallBack.selectedIndex;
    formList[requestCallBack.dataIndex!].changed = true;
    formList[requestCallBack.dataIndex!].response = requestCallBack.response;
  }
  Future<void>? updateTextBox(RequestCallBack requestCallBack)
  {
    formList[requestCallBack.dataIndex!].response = requestCallBack.response;
  }
  Future<void>? updateCheckBox(RequestCallBack requestCallBack)
  {
    formList[requestCallBack.dataIndex!].response = requestCallBack.response;
  }
  Future<void>? updateDateTimeBox(RequestCallBack requestCallBack)
  {
    formList[requestCallBack.dataIndex!].response = requestCallBack.response;
  }
  updateDependents(CallNotify callNotify,BuildContext context)
  {
    List<FormData> list = formList;
    /// loop the whole Current Form List
    for(int x=0;x<list.length;x++)
      {
        /// Checked that either current Index list does have Parent(dependent)
        if(list[x].dependent!=null&&list[x].dependent?.isDependent==true)
          {
            /// If it has a parent then find its parent Index (means index of Form list which
            /// we have sorted already with their AdmDependent data)
            int? myDependentIndex = list[x].dependent?.index;
           // PrintLogs.printLogs('depeeeeeeeuuu ${list[myDependentIndex!].selectedIndex} $x $myDependentIndex ${list[x].dependent?.index} ${list[x].dependent?.name}');

            /// Checked either my dependent(Parent) has a selected Index from his list of dropdown cz if my parent have a
            /// selected index only then i can get populated
            //PrintLogs.print('demydep $myDependentIndex ${list[myDependentIndex!].selectedIndex}');
            if(myDependentIndex!=null&&myDependentIndex!=-1&&list[myDependentIndex].selectedIndex!=-1&&list[myDependentIndex].data!=null)
              {
               // PrintLogs.print('mydep $myDependentIndex -----------');
                /// Getting my parent ReqDetail list from FORMDATA list which was encoded earlier
                /// so that reflection concept does not occur
                int? parentSelectedIndex = list[myDependentIndex].selectedIndex;
                List<ReqDetail> myParentList = List<ReqDetail>.empty(growable: true);
                jsonDecode(list[myDependentIndex].encodedRequestList).forEach((v) {
                  myParentList.add(ReqDetail.fromJson(v));
                });
                //PrintLogs.printLogs('length------ $x ${myParentList.length}');

                /// Getting my self means current value of (X) ReqDetail list from FORMDATA list which was also encoded earlier
                /// so that reflection concept does not occur
                List<ReqDetail> mySelfList = List<ReqDetail>.empty(growable: true);
                jsonDecode(list[x].encodedRequestList).forEach((v) {
                  mySelfList.add(ReqDetail.fromJson(v));
                });
                //PrintLogs.printLogs('length---yu--- $x ${mySelfList.length}');

                /// Then split my parent selected ID  Because form Parent we check 0 Index and matched
                /// with child 1 index
                String parentId = myParentList[parentSelectedIndex!].id.toString();
                var parentSplit = parentId.split('_');

                List<ReqDetail> childList = List.empty(growable: true);
                for(int childX = 1 ; childX < mySelfList.length ; childX++)
                  {
                    String childId = mySelfList[childX].id.toString();
                    var childSplit = childId.split('_');

                    if(childSplit[1] == parentSplit[0])
                      {
                        childList.add(mySelfList[childX]);
                      }
                  }
                /// here checking that either child means me have updated value only then i will update my
                /// previous values
                // if(childList.isNotEmpty)
                //   {
                    //PrintLogs.print('child');
                    childList = insertOptionalString(childList,list[x].uiTypes,context)!;
                    formList[x].data = childList;
                    formList[x].doUpdate = true;

                    /// Our logic is already done above but there is another thing need to be check

                    /// If i have changed or updated then i also have to check that either my parent
                    /// was selected means he get changed or not if he was changed then my parent child index need to be set to
                    /// -1 (as optional string) and i(child) have to set my parent 'changed' bool to false
                    /// which was set to true previously on selected by User and i(child) have to change my value
                    /// from false to true because might be i(child) have another child so he will check
                    /// that my parent is changed also and he will changed himself to (as optional string) too
                    /// because its a Loop.
                    // if(formList[x].admRequestManagerDt?.controlName != GetVariable.employeeCode
                    //     &&formList[x].admRequestManagerDt?.controlName != GetVariable.companyCode)
                    //   {
                        if(formList[myDependentIndex].changed == true)
                          {
                            //PrintLogs.printLogs('depyoo $x $myDependentIndex ');

                            //formList[myDependentIndex].changed = false;
                            formList[x].changed = true;
                            formList[x].selectedIndex = -1;
                            formList[x].multiSelected = null;
                            formList[x].isEnable = true;
                          }
                      //}
                 // }
              }
            else
              {
                /// if my parent is not selected then why i have to be enabled obviously i have to be disabled
                // if(formList[x].admRequestManagerDt?.controlName != GetVariable.employeeCode
                //     &&formList[x].admRequestManagerDt?.controlName != GetVariable.companyCode)
                // {
                  formList[x].isEnable = false;
                //}
              }
          }
    //    PrintLogs.print('final ${formList[x].data?.length}');
      }
    /// again did this thing just because if there is two child of a parent
    for(int x=0;x<list.length;x++)
      {
        if(list[x].dependent!=null&&list[x].dependent?.isDependent==true)
          {
            int? myDependentIndex = list[x].dependent?.index;
            if(myDependentIndex!=null&&myDependentIndex!=-1&&list[myDependentIndex].selectedIndex!=-1&&list[myDependentIndex].data!=null)
              {
                if(formList[myDependentIndex].changed == true)
                {
                  //PrintLogs.printLogs('depyoo $x $myDependentIndex ');

                  formList[myDependentIndex].changed = false;
                  //formList[x].changed = true;
                  // formList[x].selectedIndex = -1;
                  // formList[x].multiSelected = null;
                  // formList[x].isEnable = true;
                }
              }
          }
      }
    if(callNotify == CallNotify.notify){notifyListeners();}
  }
  List<ReqDetail>? insertOptionalString(List<ReqDetail>? nowData,UiTypes? uiTypes,BuildContext context)
  {
    /// Here we are are filtering DropDowns for now because we have to add SELECT AN OPTION string in the
    /// dropdown
    List<ReqDetail>? data = nowData;

    if(uiTypes == UiTypes.dropDown||uiTypes == UiTypes.multipleDropDown)
    {
      data?.insert(0,ReqDetail(id: -1,name: '${CallLanguageKeyWords.get(context, LanguageCodes.option)}'));
    }
    /// if its not dropdown then still we will get ReqDetail data in return from each Index
    return data;
  }
  bool? filterIsEnable(AdmRequestManagerDt admRequestManagerDt, List<ReqDetail>? reqDetail, UiTypes? uiType)
  {
    /// If this is Employee then we have to disable this
    /// if Boss then we don't but this will be done in future
    /// Also if this has ResultSet but on TextField then also disable
    // if(admRequestManagerDt.controlName == GetVariable.companyCode||
    //     admRequestManagerDt.controlName == GetVariable.employeeCode)
    // {
    //   return false;
    // }
    // if(uiType == UiTypes.textBox&&reqDetail!=null&&reqDetail.isNotEmpty)
    // {
    //   return false;
    // }
    if(admRequestManagerDt.isReadOnly==true)
      {
        return false;
      }
    print('heloksajnfasnfjhsdfbsdjbf');
    return true;
  }
  ParentDependent? filterDependent(AdmRequestManagerDt admRequestManagerDt, ReqMaster? reqMaster)
  {
    /// Finding dependents (Parents) in this method
    if(admRequestManagerDt.isDependent==true) {
      String? str = '';
      String? dependent = '';
      int? index = reqMaster?.admRequestManagerDt?.indexWhere((element) => admRequestManagerDt.dependentParameter == element.controlName);
      if(index!=-1)
      {
        //PrintLogs.printLogs('parent ${admRequestManagerDt.dependentParameter} $index');
        str = reqMaster?.admRequestManagerDt?[index!].title;
        dependent = reqMaster?.admRequestManagerDt?[index!].dependentParameter;
      }
      return ParentDependent(index,true,str,dependent);
    }
    return ParentDependent(-1,false,null,null);
  }

  Future<int?> getSelectedIndex(AdmRequestManagerDt admRequestManagerDt, List<ReqDetail>? reqDetail, UiTypes? uiType) async
  {
    /// Getting initial selected indexes over here
    ///
    if(uiType == UiTypes.dropDown||uiType == UiTypes.multipleDropDown)
    {
      if(admRequestManagerDt.controlName == GetVariable.companyCode)
      {
        int? index = reqDetail?.indexWhere((element) => element.id == loginResultSet?.headerInfo?.companyCode);
       // PrintLogs.print('company codee ${index} ${loginResultSet?.headerInfo?.companyCode}');
        if(index!=-1)
        {
          return index;
        }
      }
      if(admRequestManagerDt.controlName == GetVariable.employeeCode)
      {
        int? index = reqDetail?.indexWhere((element) => element.id == '${loginResultSet?.headerInfo?.employeeCode}_${loginResultSet?.headerInfo?.companyCode}');
       // PrintLogs.print('emp codee ${index} ${loginResultSet?.headerInfo?.companyCode}');
        if(index!=-1)
        {
          return index;
        }
      }
    }
   // PrintLogs.print('aya si');
    return -1;
  }

  void submit(BuildContext context) async {


    /// Form submission started
    List<AdmRequestValue> admRequestValueList = List.empty(growable: true);
    List<AdmRequestFile> admRequestFileList = List.empty(growable: true);
    /// In the above two lists one is for form data and the second one is for attachments

    dynamic requestCode;
    /// Checking if this form has request code if its available then get request code because we need
    /// this requestCode for form submission but if requestCode is not available then its okay too
    int? index = formList.indexWhere((element) => element.admRequestManagerDt?.controlName == GetVariable.requestCode);
    if(index!=-1)
    {
      requestCode = formList[index].data?[0].name;
    }

    bool allDone = false;
    /// We also need requestManagerId,cultureId for form submission parameters and we have that in
    /// loginResultSet
    int? requestManagerId,cultureID;
    loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));

    /// Now loop the whole formList and only check if required data is given or not if given then
    /// let it gooooo let it goooo but if it its not given then kill the process and show error to
    /// that idiot
    for(int x=0;x<formList.length;x++)
    {
      if(formList[x].response!=null&&formList[x].response?.name!=null&&formList[x].response!.name.toString().isNotEmpty&&formList[x].response!.name.toString().trim().isNotEmpty)
      {
        AdmRequestValue admRequestValue = AdmRequestValue();
        admRequestValue.cultureID = formList[x].admRequestManagerDt?.cultureID;
        admRequestValue.iD = formList[x].admRequestManagerDt?.iD;
        admRequestValue.requestManagerID = formList[x].admRequestManagerDt?.managerID;
        admRequestValue.requestCode = requestCode;
        if(formList[x].uiTypes == UiTypes.dropDown)
        {
          /// Because we have some dependents response so we will get data like
          /// 1212_1212 so the id of every drop is in [0] index
          var spl = formList[x].response?.id.toString().split('_');
          admRequestValue.controlValue = spl?[0];
        }
        else if(formList[x].uiTypes == UiTypes.multipleDropDown)
        {
          var spl = formList[x].response?.id.toString().split('_');
          admRequestValue.controlValue = spl?[0];
        }
        else
        {
          admRequestValue.controlValue = formList[x].response?.name;
        }
        admRequestValue.controlID = formList[x].admRequestManagerDt?.iD;
        requestManagerId = formList[x].admRequestManagerDt?.managerID; /// because from formlist we can get request manager id and also culture id
        cultureID = formList[x].admRequestManagerDt?.cultureID;

        admRequestValueList.add(admRequestValue);

        allDone = true;
      }
      else
      {
        /// Because user has not filled the required field so we have to stop the user and allDone is set
        /// to false so that no further work should be done
        if(formList[x].admRequestManagerDt?.isRequired==true)
        {
          allDone = false;
          SnackBarDesign.errorSnack('${formList[x].admRequestManagerDt?.title} ${CallLanguageKeyWords.get(context, LanguageCodes.RequestFormLeaveNotEmpty)}');
         // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
          break;
        }
      }

    }
    if(getFiles!=null&&getFiles!.isNotEmpty)
    {
      for(int x=1;x<getFiles!.length;x++)
      {
        AdmRequestFile admRequestFile = AdmRequestFile();
        admRequestFile.requestCode = requestCode;
        admRequestFile.cultureID = cultureID;
        admRequestFile.requestManagerID = requestManagerId;
        admRequestFile.remarks = 'Nill';
        admRequestFile.iD = x+1;
        admRequestFile.fileName = getFiles?[x].uploadedResultSet?.docName;

        admRequestFileList.add(admRequestFile);
      }
    }

    if(allDone)
    {
      dynamic companyCode = loginResultSet?.headerInfo?.companyCode;
      dynamic employeeCode = loginResultSet?.headerInfo?.employeeCode;
      EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

      companyCode = employeeInfoMapper.companyCode;
      employeeCode = employeeInfoMapper.employeeCode;

      SubmitRequestJson submitRequestJson = SubmitRequestJson();
      submitRequestJson.requestCode = requestCode;
      submitRequestJson.requestManagerID = requestFormResultSet?.reqMaster?.managerID;
      submitRequestJson.cultureID = loginResultSet?.headerInfo?.cultureID;
      submitRequestJson.employeeCode = employeeCode;
      submitRequestJson.companyCode = companyCode;
      submitRequestJson.requestDate = GetDateFormats().getFormatDate(DateTime.now());
      submitRequestJson.createdDate = GetDateFormats().getFormatDate(DateTime.now());
      submitRequestJson.approvalStatusID = 1;
      submitRequestJson.createdBy = loginResultSet?.headerInfo?.userID;
      submitRequestJson.modifiedBy = loginResultSet?.headerInfo?.userID;
      submitRequestJson.modifiedDate = GetDateFormats().getFormatDate(DateTime.now());
      submitRequestJson.admRequestValue = admRequestValueList;
      submitRequestJson.admRequestFile = admRequestFileList;

      bool check = await Provider.of<SaveRequestFormListener>(context,listen: false).start(context, submitRequestJson.toJson());
      if(check == true)
        {

          disposeAll();
          Navigator.pop(context,true);
        }

    }
    //   }
    // else
    //   {
    //     PrintLogs.print('Request code cannot be null');
    //   }
  }

  disposeAll()
  {
    getFiles?.clear();
    requestFormResultSet = null;
    loginResultSet = null;
    getFiles = null;
    apiStatus = ApiStatus.nothing;
    formList.clear();
    encodedRequest = null;
  }

  Future<ReqDetail?> updateInitialSelected(AdmRequestManagerDt admRequestManagerDt, List<ReqDetail>? reqDetail, UiTypes? uiType)async {
    if(uiType == UiTypes.dropDown||uiType == UiTypes.multipleDropDown)
    {
      if(admRequestManagerDt.controlName == GetVariable.companyCode)
      {
        int? index = reqDetail?.indexWhere((element) => element.id == loginResultSet?.headerInfo?.companyCode);
        // PrintLogs.print('company codee ${index} ${loginResultSet?.headerInfo?.companyCode}');
        if(index!=-1)
        {
          return reqDetail?[index!];
        }
      }
      if(admRequestManagerDt.controlName == GetVariable.employeeCode)
      {
        int? index = reqDetail?.indexWhere((element) => element.id == '${loginResultSet?.headerInfo?.employeeCode}_${loginResultSet?.headerInfo?.companyCode}');
        // PrintLogs.print('emp codee ${index} ${loginResultSet?.headerInfo?.companyCode}');
        if(index!=-1)
        {
          return reqDetail?[index!];
        }
      }
    }
    else if(uiType == UiTypes.textBox&&admRequestManagerDt.controlName == GetVariable.requestCode)
      {
        return reqDetail?[0];
      }
    else if(uiType == UiTypes.datePicker&&reqDetail!=null&&reqDetail.isNotEmpty)
    {
      return reqDetail[0];
    }
    return null;
  }

  void updateFileData(List<GetFileType> file) {
    getFiles = file;
  }
}



//-------------------
class FormData
{
  UiTypes? uiTypes;
  List<ReqDetail>? data;
  int? dataIndex;
  var encodedRequestList;
  int? reqDetailIndex;
  bool? doUpdate;
  List<int>? multiSelected;
  bool? isEnable;
  ReqDetail? response;
  bool? changed;
  int? selectedIndex;
  ParentDependent? dependent;
  AdmRequestManagerDt? admRequestManagerDt;
  FormData({this.response,required this.multiSelected,required this.dataIndex,required this.changed,required this.encodedRequestList,required this.doUpdate,required this.uiTypes,required this.data,required this.reqDetailIndex,required this.dependent,required this.admRequestManagerDt,required this.isEnable,this.selectedIndex});
}
enum UiTypes
{
  textBox,dropDown,checkBox,datePicker,multipleDropDown,unKnown
}
class RequestCallBack
{
  ReqDetail? response;
  int? uiIndex,dataIndex;
  UiTypes? uiTypes;
  bool? isEnable;
  ParentDependent? dependent;
  int? selectedIndex;
  List<int>? multiSelected;
  AdmRequestManagerDt? admRequestManagerDt;
  RequestCallBack(this.response,this.uiIndex,this.dataIndex,this.uiTypes,this.dependent,this.isEnable,this.admRequestManagerDt,{this.multiSelected,this.selectedIndex});
}
class RequestSender
{
  int? uiIndex,dataIndex;
  UiTypes? uiTypes;
  String? header;
  String? hint;
  List<ReqDetail>? data;
  bool? isEnable;
  ParentDependent? dependent;
  int? selectedIndex;
  List<int>? multiSelected;
  AdmRequestManagerDt? admRequestManagerDt;
  RequestSender(this.uiIndex,this.dataIndex,this.uiTypes,this.header,this.hint,this.data,this.dependent,this.isEnable,this.admRequestManagerDt,{this.multiSelected,this.selectedIndex});
}
class ParentDependent
{
  bool? isDependent;
  String? name;
  int? index;
  String? destName;
  ParentDependent(this.index,this.isDependent,this.name,this.destName);
}
class MyDependent
{
  String? name;
  int? index;
  String? dependentName;
  MyDependent(this.index,this.name,this.dependentName);
}
enum CallNotify
{
  notify,noNeed
}