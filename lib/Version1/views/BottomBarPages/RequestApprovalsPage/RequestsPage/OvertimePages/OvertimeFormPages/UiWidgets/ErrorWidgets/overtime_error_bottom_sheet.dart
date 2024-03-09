import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/OvertimeFormPages/UiWidgets/ErrorWidgets/ErrorTypes/ShiftPendingList/shift_pending_list.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../../../../../Version1/Models/TimeOffAndEnCashModel/error_result_model.dart';
import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../configs/language_codes.dart';
import 'ErrorTypes/EmployeeErrorList/employee_error_list.dart';
import 'ErrorTypes/LimitErrorList/limit_error_list.dart';

class OvertimeErrorBottomSheet extends StatefulWidget {
  final ApiResponse apiResponse;
  const OvertimeErrorBottomSheet(this.apiResponse, {Key? key}) : super(key: key);

  @override
  State<OvertimeErrorBottomSheet> createState() => _OvertimeErrorBottomSheetState();
}

class _OvertimeErrorBottomSheetState extends State<OvertimeErrorBottomSheet> {
  late ErrorResultSet? errorResultSet;
  @override
  void initState() {
    errorResultSet = widget.apiResponse.data.errorResultSet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(errorResultSet?.employeeErrorList!=null)
      {
        return ListWidget(error: widget.apiResponse.data.errorMessage,length: errorResultSet?.employeeErrorList?.length??1,itemBuilder: (context,index){
          return EmployeeErrorListWidget(errorResultSet?.employeeErrorList?[index]);
        },);
      }
    else if(errorResultSet?.limitErrorList!=null)
    {
      return ListWidget(error: widget.apiResponse.data.errorMessage,length: errorResultSet?.limitErrorList?.length??0,
        itemBuilder: (context,index){
        return LimitErrorListWidget(errorResultSet?.limitErrorList?[index]);
        },
      );
    }
    else if(errorResultSet?.shiftPendingList!=null)
    {
      return ListWidget(error: widget.apiResponse.data.errorMessage,length: errorResultSet?.shiftPendingList?.length??0,itemBuilder: (context,index){
        return ShiftPendingListWidget(errorResultSet?.shiftPendingList?[index]);
      },);
    }
    return Container();
  }
}
class ListWidget extends StatelessWidget {
  final int length;
  final String? error;
  final dynamic itemBuilder;
  const ListWidget({this.error,required this.length,required this.itemBuilder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
            margin: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), 0, ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 1)),
            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(15)), color: const Color(MyColor.colorRed1).withOpacity(0.1)),
            child: RichText(
              text: TextSpan(text: '${CallLanguageKeyWords.get(context, LanguageCodes.opps)} : ', style: GetFont.get(context, color: MyColor.colorBlack, fontSize: 1.8, fontWeight: FontWeight.w600), children: [
                TextSpan(
                  text: '${CallLanguageKeyWords.get(context, LanguageCodes.cannotDo)} $error',
                  style: GetFont.get(context, color: MyColor.colorBlack, fontSize: 1.8, fontWeight: FontWeight.w400),
                ),

              ]),
            ),
          ),
          const DividerByHeight(2),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize(context).widthOnly(6),
              ),

              itemBuilder: itemBuilder,
              separatorBuilder: (context,index){
                return DividerByHeight(3);
              },
              itemCount: length)
        ],
      ),
    );
  }
}





