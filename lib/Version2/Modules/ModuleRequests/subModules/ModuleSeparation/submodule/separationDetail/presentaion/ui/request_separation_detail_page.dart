import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleSeparation/submodule/separationDetail/presentaion/listener/separation_detail_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/applied_for_employee_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_history_view.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

import '../../../../../../../ModuleSetting/domain/repoImpl/settings_listeners.dart';

class RequestSeparationDetailPage extends StatelessWidget {
  RequestSeparationDetailPage({Key? key}) : super(key: key);

  late AllRequestDetailMapper allRequestDetailMapper;

  @override
  Widget build(BuildContext context) {
    allRequestDetailMapper = ModalRoute.of(context)!.settings.arguments as AllRequestDetailMapper;
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    return GetPageStarterScaffoldStateLess(
        title: settingsModelListener.settingsResultSet?.screenDetail?.firstWhere((element) => element.screenID.toString() == allRequestDetailMapper.screenID).screenName??'',
        body: ExtendedMultiBlocProvider(
          providers: [
            BlocProvider<SeparationDetailBloc>(create: (_) => SeparationDetailBloc(AppStateNothing(), allRequestDetailMapper: allRequestDetailMapper),)
          ],
          builder: (context) {
            return BodyData(allRequestDetailMapper);
          }
        )


    );
  }
}
class BodyData extends StatefulWidget {
  final AllRequestDetailMapper allRequestDetailMapper;
  const BodyData(this.allRequestDetailMapper, {Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<SeparationDetailBloc>(context,listen: false).fetchTimeRegulationMovementDetail(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SeparationDetailBloc,AppState>(
      listener: (context,data){},
        builder: (context,data) {
          if(data is AppStateDone)
          {
            return BodyDataNow(widget.allRequestDetailMapper);
          }
          else if(data is AppStateEmpty)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableH)}', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableA)}',topMargin: 8,width: 30);
          }
          else if(data is AppStateError)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableH)}', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableA)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
}
class BodyDataNow extends StatelessWidget {
  final AllRequestDetailMapper allRequestDetailMapper;
  BodyDataNow(this.allRequestDetailMapper, {Key? key}) : super(key: key);

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    SeparationDetailBloc data = BlocProvider.of<SeparationDetailBloc>(context,listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: const Color(MyColor.colorBackgroundDark),
                  width: 1,
                )
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestCompany)!.toUpperCase()} ',
                      style: GetFont.get(
                          context,
                          fontSize:2.0,
                          fontWeight: FontWeight.w400,
                          color: MyColor.colorGrey3
                      ),
                      children: [
                        TextSpan(
                          text: data.useCase.getSeparationDetailResult()?.displayName??'',
                          style: GetFont.get(
                              context,
                              fontSize:2.0,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                        )
                      ]
                  ),
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.separationEmployee)??'',data.useCase.getSeparationDetailResult()?.employeeName),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.separationJobTitle)??'',data.useCase.getSeparationDetailResult()?.jobTitle),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.separationEffectiveDate)??'',GetDateFormats().getFilterDate(data.useCase.getSeparationDetailResult()?.effectiveFrom)),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.separationLastWorkingDate)??'',GetDateFormats().getFilterDate(data.useCase.getSeparationDetailResult()?.lastWorkingDate)),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.separationJustification)??'',data.useCase.getSeparationDetailResult()?.remarks),
                ],
              ),
            ),
          ),
          const DividerByHeight(3),
          AppliedForEmployeeWidget(data: data.useCase.getSeparationDetailResult()?.appliedForEmployee),
          const DividerByHeight(1),
          ApprovalHistoryView(approvalList: data.useCase.getApprovalListForView()),
          if(data.useCase.canAdminApprove() == true && allRequestDetailMapper.isApprovalScreen == true)...[
            SizedBox(height: ScreenSize(context).heightOnly( 4),),
            ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.announcementReject)}',buttonColor: MyColor.colorBlack,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: rejectPressed,),
            SizedBox(height: ScreenSize(context).heightOnly( 2),),
            ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.approvalBodyPanelButton2)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: approvePressed,),
            SizedBox(height: ScreenSize(context).heightOnly( 6),),
          ],

          SizedBox(height: ScreenSize(context).heightOnly( 10),),

        ],
      ),
    );
  }
  int? getColorOfLeaveStatusText(int? timeOffType)
  {
    switch(timeOffType)
    {
      case 1:
        return MyColor.colorT2;
      case 3:
        return MyColor.colorT6;
      case 2:
        return MyColor.colorT4;
      case 8:
        return MyColor.colorT6;
      default:
        return MyColor.colorT6;
    }
  }
  void rejectPressed()
  {
    BlocProvider.of<SeparationDetailBloc>(context,listen: false).actionButtonPressed(context,AcceptReject.reject,3);
  }

  void approvePressed()
  {
    BlocProvider.of<SeparationDetailBloc>(context,listen: false).actionButtonPressed(context,AcceptReject.accept,2);
  }
}
class BodyWidget extends StatelessWidget {
  final String? header,body;
  const BodyWidget(this.header,this.body, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header??'',
              style: GetFont.get(
                  context,
                  fontSize:1.8,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
              ),
            ),
            SizedBox(height: ScreenSize(context).widthOnly( 2),),
            Flexible(
              flex:0,
              child: Text(
                body??'',
                style: GetFont.get(
                    context,
                    fontSize:1.6,
                    fontWeight: FontWeight.w400,
                    color: MyColor.colorBlack
                ),
              ),
            ),
          ],

    );
  }
}

