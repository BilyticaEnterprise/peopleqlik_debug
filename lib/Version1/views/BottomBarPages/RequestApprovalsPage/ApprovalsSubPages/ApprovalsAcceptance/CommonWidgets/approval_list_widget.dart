import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/Models/ApprovalsModel/get_approvals_detail_model.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';

import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../utils/date_formats.dart';
import '../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../utils/screen_sizes.dart';
import '../approval_acceptance_rejection_page.dart';

class ApprovalListWidget extends StatelessWidget {
  // final List<ApprovalHistory>? uniqueList;
  final List<List<ApprovalHistory>>? approvalsList;
  const ApprovalListWidget(this.approvalsList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(2)),
        itemBuilder: (context,index)
        {
          return ListOfApprovalHistoryBody(approvalsList?[index]);
        },
        separatorBuilder: (context,index){
          return SizedBox(height: ScreenSize(context).heightOnly( 2),);
        },
        itemCount: approvalsList?.length??0
    );
  }
}
class ListOfApprovalHistoryBody extends StatelessWidget {
  final List<ApprovalHistory>? approvalHistory;
  const ListOfApprovalHistoryBody(this.approvalHistory, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.8)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: const Color(MyColor.colorBackgroundDark),
            width: 1,
          )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  '${CallLanguageKeyWords.get(context, LanguageCodes.stage)} # ${approvalHistory?.first.hierarchyID}',
                  style: GetFont.get(
                      context,
                      fontWeight: FontWeight.w600,
                      fontSize: 1.8,
                      color: MyColor.colorBlack
                  ),
                ),
              ),
              Text(
                approvalHistory?[0].company??'',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.8,
                    color: MyColor.colorBlack
                ),
              ),
            ],
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(2)),
              itemBuilder: (context,index)
              {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: approvalHistory?[index].statusName??'',
                          style: GetFont.get(
                              context,
                              fontSize: 1.8,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                          children: [
                            TextSpan(
                              text:' ${CallLanguageKeyWords.get(context, LanguageCodes.approvalKey)} ',
                              style: GetFont.get(
                                  context,
                                  fontSize: 1.8,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorBlack
                              ),
                            ),
                            TextSpan(
                              text:approvalHistory?[index].userName??'',
                              style: GetFont.get(
                                  context,
                                  fontSize: 1.8,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorBlack
                              ),
                            ),
                          ]
                      ),
                    ),
                    const DividerByHeight(0.5),
                    RichText(
                      text: TextSpan(
                          text: '${CallLanguageKeyWords.get(context, LanguageCodes.on)} ',
                          style: GetFont.get(
                              context,
                              fontSize: 1.6,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                          children: [
                            TextSpan(
                              text: GetDateFormats().getFilterDateTime(approvalHistory?[index].modifiedDate)??'',
                              style: GetFont.get(
                                  context,
                                  fontSize: 1.6,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.colorGrey3
                              ),
                            ),
                          ]
                      ),
                    ),
                  ],

                );
              },
              separatorBuilder: (context,index){
                return SizedBox(height: ScreenSize(context).heightOnly(1.8),);
              },
              itemCount: approvalHistory?.length??0
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                  text: '${CallLanguageKeyWords.get(context, LanguageCodes.documentNo)}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.8,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorGrey3
                  ),
                  children: [
                    TextSpan(
                      text:' ',
                      style: GetFont.get(
                          context,
                          fontSize: 2.2,
                          fontWeight: FontWeight.w400,
                          color: MyColor.colorBlack
                      ),
                    ),
                    TextSpan(
                      text:approvalHistory?[0].documentNo??'',
                      style: GetFont.get(
                          context,
                          fontSize: 1.8,
                          fontWeight: FontWeight.w400,
                          color: MyColor.colorBlack
                      ),
                    ),
                  ]
              ),
            ),
          )
        ],
      ),
    );
  }
}
