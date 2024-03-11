import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_form_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_save_form_listener.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/Version1/Models/RequestsModel/get_request_separation_form_model.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleEncashment/subModules/encashmentFormModule/utils/special_textfield_widget.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/SeperationRequestPages/SeparationFormWidgets/datepicker_widget.dart';
import 'package:peopleqlik_debug/utils/Buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/ScreenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/utils/TextFieldRemarks/text_remarks_header.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/hide_keyboard.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../Version1/Models/RequestsModel/request_data_taker.dart';
import '../../../../../../utils/Appbars/generic_app_bar.dart';
import '../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../../utils/Reuse_LogicalWidgets/current_employee_name_note.dart';
import '../../../GlobalEmployeeSearchUi/call_employee_search_ui.dart';
import 'SeparationFormWidgets/text_field_widget.dart';

class RequestSeparationFormPage extends StatelessWidget {
  RequestSeparationFormPage({Key? key}) : super(key: key);
  PanelController panelController = PanelController();
  RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)!.settings.arguments as RequestDataTaker;
    Provider.of<GlobalSelectedEmployeeController>(context,listen: false).saveTempEmployee();

    return WillPopScope(
      onWillPop: ()async{
        Provider.of<GlobalSelectedEmployeeController>(context,listen: false).specialPop(context);
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<RequestSeparationSaveFormListener>(create: (_) => RequestSeparationSaveFormListener()),
          ChangeNotifierProvider<RequestSeparationFormListener>(create: (_) => RequestSeparationFormListener())
        ],
        child: GestureDetector(
          onTap: (){HideShowKeyboard.hide(context);},
          child:
          GetPageStarterScaffoldStateLess(
            body: BodyNow(requestDataTaker),
            appBar: Consumer<GlobalSelectedEmployeeController>(
                builder: (context, employeeData, child) {
                  return EmployeeAppBarWidget(
                    requestDataTaker?.title??'',
                    onBackTap: (){
                      Provider.of<GlobalSelectedEmployeeController>(context,listen: false).specialPop(context);
                    },
                    selectEmployeeTap: () {
                      EmployeeSearchBottomSheet().show(
                          context,
                              (employeeInfoMapper)
                          {
                            Provider.of<RequestSeparationFormListener>(context,listen: false).start(context);
                          }
                      );
                    },
                    removeEmployeeTap: () async {
                      await employeeData.resetEmployee();
                      Provider.of<RequestSeparationFormListener>(context,listen: false).start(context);
                    },
                    hidePlusButton: true,
                    employeeInfoMapper: employeeData.getEmployee(),
                  );
                }
            ),
              checkEmployeeIfExistInCurrentCompany: Provider.of<GlobalSelectedEmployeeController>(context,listen: false).checkIfCurrentUserCompanyMatches(),
              employeeChangeCurrentCompanyTap: (){
                EmployeeSearchBottomSheet().show(
                    context,
                        (employeeInfoMapper)
                    {
                      Provider.of<RequestSeparationFormListener>(context,listen: false).start(context);
                    }
                );
              }
          ),
          // Scaffold(
          //     backgroundColor: const Color(MyColor.colorWhite),
          //     body: SlidingUpPanel(
          //       key: const Key('separateForm'),
          //       maxHeight: ScreenSize(context).heightOnly(90),
          //       minHeight: 0,
          //       isDraggable: false,
          //       panelSnapping: true,
          //       defaultPanelState: PanelState.CLOSED,
          //       controller: panelController,
          //       parallaxEnabled: true,
          //       backdropEnabled: true,
          //       backdropColor: const Color(MyColor.colorGreySecondary),
          //       header: RequestsPanelHeader(panelController),
          //       parallaxOffset: .5,
          //       panelBuilder: (sc) => const SearchEmployeeWidget(),
          //       borderRadius: const BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          //       body: NestedScrollView(
          //         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          //           return <Widget>[
          //             SliverAppBar(
          //                 automaticallyImplyLeading: false,
          //                 pinned: false,
          //                 floating: true,
          //                 backgroundColor: const Color(MyColor.colorWhite),
          //                 snap: true,
          //                 elevation: 2,
          //                 titleSpacing: 0,
          //                 title: FormSubmitAppBarWidget(CallSettingsKeyWords.get(context, LanguageCodes.separationTitle)??'',panelController,key: Key('${CallSettingsKeyWords.get(context, LanguageCodes.separationTitle)}SepForm'),hideEmployeeSearch: false,)
          //             ),
          //           ];
          //         },
          //         body: Consumer<CheckInternetConnection>(
          //             builder: (context,data,child) {
          //               if(data.internetConnectionEnum == InternetConnectionEnum.available)
          //               {
          //                 return Padding(
          //                   padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          //                   child: BodyNow(requestDataTaker),
          //                 );
          //               }
          //               else
          //               {
          //                 return NotAvailable(GetAssets.internetAnim, '${CallSettingsKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallSettingsKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
          //               }
          //             }
          //         ),
          //       ),
          //     )
          // ),
        ),
      ),
    );
  }
}
class BodyNow extends StatefulWidget {
  final RequestDataTaker? requestDataTaker;
  const BodyNow(this.requestDataTaker, {Key? key}) : super(key: key);

  @override
  _BodyNowState createState() => _BodyNowState();
}

class _BodyNowState extends State<BodyNow> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // RequestDataTaker? requestDataTaker = RequestDataTaker(widget.requestDataTaker!.id, widget.requestDataTaker!.title,requestsEnum: RequestsEnum.separationForm);
      // Provider.of<EmployeeSearchController>(context,listen: false).requestDataTaker = requestDataTaker;
      //Provider.of<EmployeeSearchController>(context,listen: false).justUpdatePage(EmployeeCalledForPage.separationForm);
      Provider.of<RequestSeparationFormListener>(context,listen: false).start(context);
    }
      );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<RequestSeparationFormListener>(
        builder: (context, data, child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return BodyData(data.getSeparationEmployeeResultSet,key: Key('sad${data.randomNumber}'),);
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
          }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
}
class BodyData extends StatefulWidget {
  final GetSeparationEmployeeResultSet? getSeparationEmployeeResultSet;

  BodyData(this.getSeparationEmployeeResultSet, {Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  late BuildContext mContext;
  FocusScopeNode? focusScopeNode;
//  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    focusScopeNode?.dispose();
  //  textEditingController.dispose();
    super.dispose();
  }
  @override
  void initState() {
  //  textEditingController = TextEditingController();
    focusScopeNode = FocusScopeNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RequestSeparationSaveFormListener>(mContext,listen: false).selectedEmployee(widget.getSeparationEmployeeResultSet?.separtionDays?.noticePeriod??0,widget.getSeparationEmployeeResultSet?.separtionDays?.isMandatoryToServerNoticePeriod??false,context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    mContext = context;
    return Consumer<RequestSeparationSaveFormListener>(
          builder: (context,dataSeparationSave,child) {
            if(dataSeparationSave.name!=null) {
              //PrintLogs.printLogs('emplotereter ${dataSeparationSave.employeeCode}');
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(height: ScreenSize(context).heightOnly( 1),),
                    // SeparationRequestTextField(RequestSeparationData(index: 0,title: CallLanguageKeyWords.get(context, LanguageCodes.separationEmployee)??'',data: dataSeparationSave.name??'',isEnable: false,isRequired: false,callBack: callbackMethod),focusScopeNode!,key: Key('${Random().nextInt(100)}0text'),),
                    CurrentEmployeeNoteWidget(),
                    JobUiBody(dataSeparationSave,key: Key('${dataSeparationSave.employeeCode}'),),
                  ],
                ),
              );
            }
            else
              {
                return Container();
              }
        }
    );
  }

  callbackMethod(RequestSeparationCallBack data) {
  }
}
class JobUiBody extends StatefulWidget {
  //final GetSeparationEmployeeResultSet? getSeparationEmployeeResultSet;
  final RequestSeparationSaveFormListener dataSeparationSave;
  const JobUiBody(this.dataSeparationSave, {Key? key}) : super(key: key);

  @override
  State<JobUiBody> createState() => _JobUiBodyState();
}

class _JobUiBodyState extends State<JobUiBody> {
  FocusScopeNode? focusScopeNode;
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    focusScopeNode?.dispose();
    textEditingController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    textEditingController = TextEditingController();
    //textEditingController.text = 'chfjftiiyiritrurufjfjrut hdfufjdjfjbcjffifiti ei. w withe wI iwitwtwitwkgssgkskyskyskysoysfksitaktakgsoalstsylwktakgsitskyakystosoyslybbbvvvdududfiffjdhdtsoetsotskysotskywitsktajgsjrskgajfsjtajajraktwjtsitakgajtsitaktstiskywjtsjtskyajtstiaktsjtsjtsktaktsktsktsktsitstistjsktsktsktsitsitsitsitsitsitsitsgsitsitssiktsktskstsykdlyeyekwwktwkteekyskywykstwkwtwtkwktwktwktwktwtiwitwktwkwktwktetkwkyektwktwtsktwktwhdfjfjfjrfururirutufufifififitffufutffurruurtitthfui hffjffjdjjfstjstjsjatjstjstydhddhhddufjf';
    focusScopeNode = FocusScopeNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        SeparationRequestTextField(RequestSeparationData(index: 1,title: CallLanguageKeyWords.get(context, LanguageCodes.separationJobTitle)??'',data: widget.dataSeparationSave.jobTitle??'',isEnable: false,isRequired: true,callBack: callback),focusScopeNode!,key: const Key('1text'),),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        CalenderSeparationTimeWidget(RequestSeparationData(index: 2,title: CallLanguageKeyWords.get(context, LanguageCodes.separationEffectiveDate)??'',data: widget.dataSeparationSave.saveSeparationMapper?.effectiveFrom,isEnable: true,isRequired: true,callBack: callback,hint: '${CallLanguageKeyWords.get(context, LanguageCodes.select)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationEffectiveDate)}'),key: const Key('2text'),),
        if(widget.dataSeparationSave.saveSeparationMapper?.effectiveFrom!=null)...[
          SizedBox(height: ScreenSize(context).heightOnly( 2),),
          CalenderSeparationTimeWidget(RequestSeparationData(index: 3,title: CallLanguageKeyWords.get(context, LanguageCodes.separationLastWorkingDate)??'',data: widget.dataSeparationSave.saveSeparationMapper?.lastWorkingDate??'',isEnable: widget.dataSeparationSave.enableLastWorkingDate==true?false:true,isRequired: true,callBack: callback,hint: '${CallLanguageKeyWords.get(context, LanguageCodes.select)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationEffectiveDate)}'),key: Key(widget.dataSeparationSave.saveSeparationMapper?.lastWorkingDate??'3text'),),
        ],
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
              child: HeaderTextRemarksField('${CallLanguageKeyWords.get(context, LanguageCodes.separationJustification)}','${CallLanguageKeyWords.get(context, LanguageCodes.separationWriteSome)}',textEditingController,focusScopeNode!,true,callBack: remarksCallback,key: const Key('remarkssan'),fromSeparation: true,paddingIs: 0,margin: 0,),
            ),
          ],
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 6),),
        ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsaddFormButton)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: confirmPressed,),
        SizedBox(height:ScreenSize(context).heightOnly(16),),

      ],
    );
  }

  callback(RequestSeparationCallBack data) {
    if(data.index == 2)
      {
        //PrintLogs.printLogs('indexxxsds asdadas');
        Provider.of<RequestSeparationSaveFormListener>(context,listen: false).selectedEffectiveDate(data.data);
      }
  }
  remarksCallback(text)
  {
    Provider.of<RequestSeparationSaveFormListener>(context,listen: false).remarksData(text);
  }
  confirmPressed()
  {
    Provider.of<RequestSeparationSaveFormListener>(context,listen: false).submit(context);
  }
}

