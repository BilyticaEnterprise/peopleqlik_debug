import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/leave_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/presentation/listener/get_leave_detail_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/presentation/ui/time_off_detail_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

class TimeOffViewWidget extends StatelessWidget {
  final GetLeaveDetailBloc data;
  const TimeOffViewWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    List<AllApprovalTypes>? allApprovalTypesList = Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.allApprovalTypesList;
    PrintLogs.printLogs('accpeteasds ${ data.useCase.getLeaveDetailResult()?.approvalStatusID}');
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
          padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color(MyColor.colorBackgroundLight)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.useCase.getLeaveDetailResult()?.typeTitle??'',
                style: GetFont.get(
                    context,
                    fontSize: 2.2,
                    fontWeight: FontWeight.w600,
                    color: getColorOfLeaveType(data.useCase.getLeaveDetailResult()?.approvalStatusID)
                ),
              ),
              SizedBox(height: ScreenSize(context).heightOnly( 0.6),),
              RichText(
                text: TextSpan(
                    text: '${CallLanguageKeyWords.get(context, LanguageCodes.Hello)}, ',
                    style: GetFont.get(
                        context,
                        fontSize: 1.6,
                        fontWeight: FontWeight.w400,
                        color: MyColor.colorGrey3
                    ),
                    children: [
                      TextSpan(
                        text: '${data.useCase.getLeaveDetailResult()?.fullName}',
                        style: GetFont.get(
                            context,
                            fontSize: 1.6,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorGrey3
                        ),
                      ),
                      TextSpan(
                        text: ' ${CallLanguageKeyWords.get(context, LanguageCodes.headerOne)}',
                        style: GetFont.get(
                            context,
                            fontSize: 1.6,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorGrey3
                        ),
                      )
                    ]
                ),
              ),
              SizedBox(height: ScreenSize(context).heightOnly( 2),),
              TimeDetailInfoWidget(header: '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDate)}:    ',value: '${GetDateFormats().getFilterDate(data.useCase.getLeaveDetailResult()?.requestDate)}',),
              SizedBox(height: ScreenSize(context).heightOnly( 1),),
              TimeDetailInfoWidget(header: '${CallLanguageKeyWords.get(context, LanguageCodes.RequestApplicationCode)}:    ',value: '${data.useCase.getLeaveDetailResult()?.applicationCode}',),
              SizedBox(height: ScreenSize(context).heightOnly( 1),),
              TimeDetailInfoWidget(header: '${CallLanguageKeyWords.get(context, data.useCase.getLeaveDetailResult()?.unitID == GetVariable.isTime?LanguageCodes.TotalMinutes:LanguageCodes.TotalDays)}:    ',value: '${getTotalLeavesCount(data.useCase.getLeaveDetailResult()?.leaveTimeOff)}',),
              SizedBox(height: ScreenSize(context).heightOnly( 1),),
              TimeDetailInfoWidget(header: '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffEmerContact3)}:    ',value: data.useCase.getLeaveDetailResult()?.eCIName,),
              SizedBox(height: ScreenSize(context).heightOnly( 1),),
              TimeDetailInfoWidget(header: '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffEmerContact1)}:    ',value: data.useCase.getLeaveDetailResult()?.eCINumber??'',),
            ],
          ),
        ),
        if(data.useCase.getLeaveDetailResult()?.remarks!=null&&data.useCase.getLeaveDetailResult()!.remarks!.isNotEmpty)...[
          SizedBox(height: ScreenSize(context).heightOnly( 3),),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(MyColor.colorBackgroundLight)
              ),
              //padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffAnyRemarks1)}',
                    style: GetFont.get(
                        context,
                        fontSize: 2.2,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorBlack
                    ),
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 1),),
                  Text(
                    '${data.useCase.getLeaveDetailResult()?.remarks}.',
                    style: GetFont.get(
                        context,
                        fontSize: 1.8,
                        fontWeight: FontWeight.w400,
                        color: MyColor.colorBlack
                    ),
                  ),
                ],
              )
          ),
        ],
        SizedBox(height: ScreenSize(context).heightOnly( 3),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${CallLanguageKeyWords.get(context, LanguageCodes.LeaveStatus)}',
                  style: GetFont.get(
                      context,
                      fontSize: 2.2,
                      fontWeight: FontWeight.w600,
                      color: MyColor.colorBlack
                  ),
                ),
              ),
              Text(
                '${allApprovalTypesList?.firstWhere((element) => element.statusID == data.useCase.getLeaveDetailResult()?.approvalStatusID).statusName}',
                style: GetFont.get(
                    context,
                    fontSize: 2.2,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                ),
              )
            ],
          ),
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
          child: ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context,index){
                return Container(
                  padding: EdgeInsets.all(ScreenSize(context).heightOnly( 2)),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: const Color(MyColor.colorWhite),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 0.0,
                          blurRadius: 14,
                          offset: const Offset(3.0, 3.0)),
                      BoxShadow(
                          color: Colors.grey.shade400,
                          spreadRadius: 0.0,
                          blurRadius: 14 / 2.0,
                          offset: const Offset(3.0, 3.0)),
                      BoxShadow(
                          color: Colors.grey.shade50,
                          spreadRadius: 2.0,
                          blurRadius: 14,
                          offset: const Offset(0.0, -3.0)),
                      BoxShadow(
                          color: Colors.grey.shade50,
                          spreadRadius: 2.0,
                          blurRadius: 14 / 2,
                          offset: const Offset(0.0, -3.0)),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${CallLanguageKeyWords.get(context, LanguageCodes.LeaveFrom)}',
                              style: GetFont.get(
                                  context,
                                  fontSize: 1.8,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorBlack
                              ),
                            ),
                          ),
                          Text(
                            '${GetDateFormats().getFilterDate(data.useCase.getLeaveDetailResult()?.leaveTimeOff?[index].leaveFrom)} ${data.useCase.getLeaveDetailResult()?.unitID == GetVariable.isTime?GetDateFormats().getFilterTime(data.useCase.getLeaveDetailResult()?.leaveTimeOff?[index].leaveFrom):""}',
                            style: GetFont.get(
                                context,
                                fontSize: 1.8,
                                fontWeight: FontWeight.w400,
                                color: MyColor.colorBlack
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: ScreenSize(context).heightOnly( 2),),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${CallLanguageKeyWords.get(context, LanguageCodes.LeaveTo)}',
                              style: GetFont.get(
                                  context,
                                  fontSize: 1.8,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorBlack
                              ),
                            ),
                          ),
                          Text(
                            '${GetDateFormats().getFilterDate(data.useCase.getLeaveDetailResult()?.leaveTimeOff?[index].leaveTo)} ${data.useCase.getLeaveDetailResult()?.unitID == GetVariable.isTime? GetDateFormats().getFilterTime(data.useCase.getLeaveDetailResult()?.leaveTimeOff?[index].leaveTo):""}',
                            style: GetFont.get(
                                context,
                                fontSize: 1.8,
                                fontWeight: FontWeight.w400,
                                color: MyColor.colorBlack
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: ScreenSize(context).heightOnly( 2),),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${CallLanguageKeyWords.get(context, data.useCase.getLeaveDetailResult()?.unitID == GetVariable.isTime?LanguageCodes.TotalMinutes:LanguageCodes.TotalDays)}',
                              style: GetFont.get(
                                  context,
                                  fontSize: 1.8,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorBlack
                              ),
                            ),
                          ),
                          Text(
                            '${data.useCase.getLeaveDetailResult()?.leaveTimeOff?[index].totalLeaves}',
                            style: GetFont.get(
                                context,
                                fontSize: 1.8,
                                fontWeight: FontWeight.w400,
                                color: MyColor.colorBlack
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context,index){
                return SizedBox(height: ScreenSize(context).heightOnly( 2),);
              },
              itemCount: data.useCase.getLeaveDetailResult()?.leaveTimeOff?.length??0
          ),
        ),
      ],
    );
  }

  int? getColorOfLeaveType(int? timeOffType)
  {
    switch(timeOffType)
    {
      case 1:
        return MyColor.colorT12;
      case 3:
        return MyColor.colorT56;
      case 2:
        return MyColor.colorT34;
      default:
        return MyColor.colorPrimary;
    }
  }

  getTotalLeavesCount(List<LeaveTimeOff>? timeOffDetail)
  {
    if(timeOffDetail!=null&&timeOffDetail.isNotEmpty)
    {
      double count = 0;
      for(int x=0;x<timeOffDetail.length;x++)
      {
        count = count + timeOffDetail[x].totalLeaves!;
      }
      return count;
    }
    return 0;
  }
}
