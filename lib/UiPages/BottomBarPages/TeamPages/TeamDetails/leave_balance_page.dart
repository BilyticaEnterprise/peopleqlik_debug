import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/dividers.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/dividers.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:provider/provider.dart';

import '../../../../BusinessLogicModel/Enums/apistatus_enum.dart';
import '../../../../BusinessLogicModel/Listeners/TeamGetListeners/get_leave_balance_listener.dart';
import '../../../../BusinessLogicModel/Listeners/TeamGetListeners/team_detail_listener.dart';
import '../../../../BusinessLogicModel/Models/TeamModel/get_employee_leave_balance_mapper.dart';
import '../../../../BusinessLogicModel/Models/TeamModel/leave_balance_model.dart';
import '../../../../src/colors.dart';
import '../../../../src/fonts.dart';
import '../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../Reuse_Widgets/ErrorsUi/not_available.dart';
import '../../../Reuse_Widgets/circular_indicator_customized.dart';
import '../../../Reuse_Widgets/horizontal_vertical_line.dart';

class LeaveBalancePage extends StatelessWidget {
  LeaveBalancePage({super.key});

  ForBalanceEmployeeInfo? forBalanceEmployeeInfo;
  @override
  Widget build(BuildContext context) {
    forBalanceEmployeeInfo = ModalRoute.of(context)?.settings.arguments as ForBalanceEmployeeInfo?;
    return ChangeNotifierProvider<GetEmployeeLeaveBalanceListener>(
      create: (_) => GetEmployeeLeaveBalanceListener(forBalanceEmployeeInfo: forBalanceEmployeeInfo),
      builder: (context, snapshot) {
        return GetPageStarterScaffold(
          title: CallLanguageKeyWords.get(context, LanguageCodes.leaveBalance)??'',
          body: BodyData(),
        );
      }
    );
  }
}
class BodyData extends StatefulWidget {
  const BodyData({super.key});

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetEmployeeLeaveBalanceListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetEmployeeLeaveBalanceListener>(
      builder: (context, data, child) {
        if(data.apiStatus == ApiStatus.done)
        {
          return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(6),ScreenSize(context).heightOnly(2),ScreenSize(context).widthOnly(6),ScreenSize(context).heightOnly(10)),
              itemBuilder: (context,index)
              {
                return LeaveBalanceWidget(number: index+1,data: data.resultSet?[index],);
              },
              separatorBuilder: (context,index)
              {
                return const DividerByHeight(3);
              },
              itemCount: data.resultSet?.length??0
          );
        }
        else if(data.apiStatus == ApiStatus.empty)
        {
          return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.leaveBalanceAssignedHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.leaveBalanceAssignedValue)}',topMargin: 8,width: 40,);
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
class LeaveBalanceWidget extends StatelessWidget {
  final int number;
  final LeaveBalanceResultSet? data;
  const LeaveBalanceWidget({required this.number, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
              color: const Color(MyColor.colorPrimary),
              width: 0.7
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenSize(context).heightOnly(2.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: RichText(
                text: TextSpan(
                    text: '#$number ${CallLanguageKeyWords.get(context, LanguageCodes.LeaveType)} : ',
                    style: GetFont.get(
                        context,
                        fontSize: 2.0,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorGrey3
                    ),
                  children: [
                    TextSpan(
                      text: data?.leaveName??'',
                      style: GetFont.get(
                          context,
                          fontSize: 2.0,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorIndigo
                      ),
                    )
                  ]
                ),
              ),
            ),
            const DividerByHeight(2),
            LeaveBalanceTypeWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.totalAssignedBalance)}',value: '${data?.totalBalance??0}',),
            const DividerByHeight(0.8),
            LeaveBalanceTypeWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.carryOverBalance)}',value: '${data?.carryOverBalance??0}',),
            const DividerByHeight(0.4),
            const HorizontalLine(width: double.infinity,),
            const DividerByHeight(0.4),
            LeaveBalanceTypeWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.policyDeduction)}',value: '${data?.policyDeduction??0}',),
            const DividerByHeight(0.8),
            LeaveBalanceTypeWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.encashedBalance)}',value: '${data?.encashedBalance??0}',),
            const DividerByHeight(0.8),
            LeaveBalanceTypeWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.availedBalance)}',value: '${data?.availedBalance??0}',),

            const DividerByHeight(0.4),
            const HorizontalLine(width: double.infinity,),
            const DividerByHeight(0.4),
            LeaveBalanceTypeWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.currentLeftBalance)}',value: '${data?.nETbalance??0}',isBold: true,),
            const DividerByHeight(0.8),
          ],
        ),
      ),
    );
  }
}

class LeaveBalanceTypeWidget extends StatelessWidget {
  final String text;
  final String value;
  final bool? isBold;
  const LeaveBalanceTypeWidget({required this.text,required this.value,this.isBold,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: GetFont.get(
                context,
                fontSize: isBold==true?1.8:1.6,
                fontWeight: isBold==true?FontWeight.w600:FontWeight.w400,
                color: MyColor.colorBlack
            ),
          ),
        ),
        Text(
          value,
          style: GetFont.get(
              context,
              fontSize: isBold==true?1.8:1.6,
              fontWeight: isBold==true?FontWeight.w600:FontWeight.w400,
              color: MyColor.colorBlack
          ),
        ),
      ],
    );
  }
}
