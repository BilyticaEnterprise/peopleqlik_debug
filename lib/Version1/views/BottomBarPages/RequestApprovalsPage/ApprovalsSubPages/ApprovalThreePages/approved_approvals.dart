import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_collector.dart';
import 'package:peopleqlik_debug/Version1/models/ApprovalsModel/get_approvals_list.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_rejection_page.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_appceptance_leave_request_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/get_all_approval_mapper.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';
import '../../../../../../Version1/models/ApprovalsModel/approval_detail_mapper.dart';
import '../../../../../../Version1/models/ApprovalsModel/approval_result_set_data.dart';
import 'package:peopleqlik_debug/utils/SkeletetonAnimation/skeleton_text.dart';

import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';

class ApprovedApprovals extends StatelessWidget {
  final ApprovalPageEnum approvalPageEnum;
  final List<ApprovalResultSet>? approvalResultSet;
  const ApprovedApprovals(this.approvalPageEnum, this.approvalResultSet, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 2),bottom: ScreenSize(context).heightOnly( 10)),
        itemBuilder: (context,index)
        {
          return Provider.of<ApprovalCollector>(context,listen: false).reachedEnd&&index== approvalResultSet!.length-1?
          Container(
            height: ScreenSize(context).heightOnly( 12),
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: const Color(MyColor.colorBackgroundDark),
                  width: 1,
                )
            ),
            child: SkeletonAnimation(
                key: Key('requestShimmerApprove$index'),
                shimmerColor:Colors.white70,
                gradientColor:const Color(MyColor.colorGreyPrimary).withOpacity(0.2),
                curve:Curves.fastOutSlowIn, child: Container()),
          ):Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: const Color(MyColor.colorBackgroundDark),
                  width: 1,
                )
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Material(
                color: const Color(MyColor.colorTransparent),
                child: InkWell(
                  splashColor: const Color(MyColor.colorGrey0),
                  onTap: (){

                    ApprovalCollector approvalCollector = Provider.of<ApprovalCollector>(context,listen: false);
                    Navigator.pushNamed(context, approvalCollector.getPageName(approvalResultSet?[index].screenID),arguments: GetApprovalDetailMapper.getApprovalDetailMapper(approvalResultSet?[index],isApprovalScreen: false));

                    // if(approvalResultSet?[index].screenID == GetVariable.requestScreenId)
                    // {
                    //   var spl = approvalResultSet?[index].documentNo?.split(',');
                    //   if(spl!=null&&spl.isNotEmpty&&spl.length>=2)
                    //   {
                    //     Navigator.pushNamed(context, CurrentPage.ApprovalRequestFormPage,arguments: ApprovalRequestDetailData(spl[1],spl[0],false,ApprovalDetailMapper.getApprovalDetailMapper(approvalResultSet?[index])));
                    //   }
                    //   else
                    //   {
                    //     SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr31)}');
                    //     // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'',color: MyColor.colorRed));
                    //   }
                    //
                    // }
                    // else if(approvalResultSet?[index].screenID == AppConstants.requestEnCashmentScreenID)
                    // {
                    //   Navigator.pushNamed(context, CurrentPage.RequestEncashmentDetailPage,arguments: GetApprovalDetailMapper.getApprovalDetailMapper(approvalResultSet?[index],isApprovalScreen: false));
                    // }
                    // else if(approvalResultSet?[index].screenID == AppConstants.requestSeparationScreenID)
                    // {
                    //   Navigator.pushNamed(context, CurrentPage.RequestSeparationDetailPage,arguments: GetApprovalDetailMapper.getApprovalDetailMapper(approvalResultSet?[index],isApprovalScreen: false));
                    // }
                    // else if(approvalResultSet?[index].screenID == AppConstants.requestTimeRegulationScreenID)
                    //   {
                    //     Navigator.pushNamed(context, CurrentPage.AcceptanceTimeRegulationPage,arguments: ApprovalResultSetData(ApprovalDetailMapper.getApprovalDetailMapper(approvalResultSet?[index]),false));
                    //   }
                    // else if(approvalResultSet?[index].screenID == AppConstants.requestOverTimeScreenID)
                    // {
                    //   Navigator.pushNamed(context, CurrentPage.OvertimeDetailPage,arguments: GetApprovalDetailMapper.getApprovalDetailMapper(approvalResultSet?[index],isApprovalScreen: false));
                    // }
                    // else if(approvalResultSet?[index].screenID == AppConstants.requestShiftScreenID)
                    // {
                    //   Navigator.pushNamed(context, CurrentPage.ApprovalShiftDetailPage,arguments: ApprovalResultSetData(ApprovalDetailMapper.getApprovalDetailMapper(approvalResultSet?[index]),false));
                    // }
                    // else {
                    //   Navigator.pushNamed(context, CurrentPage.ApprovalAcceptanceRejectionPage,arguments: ApprovalResultSetData(ApprovalDetailMapper.getApprovalDetailMapper(approvalResultSet?[index]),false));
                    // }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.8)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: ScreenSize(context).heightOnly( 1.4),
                              margin: EdgeInsets.only(top: ScreenSize(context).heightOnly( 0.6)),
                              height: ScreenSize(context).heightOnly( 1.4),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(MyColor.colorPrimary)
                              ),
                            ),
                            SizedBox(width: ScreenSize(context).heightOnly( 1.5),),
                            Expanded(
                              child: Text(
                                GetDateFormats().getFilterDate(approvalResultSet?[index].documentDate)??'',
                                style: GetFont.get(
                                    context,
                                    fontSize: 2.2,
                                    fontWeight: FontWeight.w600,
                                    color: MyColor.colorBlack
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenSize(context).heightOnly( 1),),
                            RichText(
                              text: TextSpan(
                                  text: '#',
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
                                      text:approvalResultSet?[index].documentNo??'',
                                      style: GetFont.get(
                                          context,
                                          fontSize: 1.8,
                                          fontWeight: FontWeight.w400,
                                          color: MyColor.colorBlack
                                      ),
                                    ),
                                  ]
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: ScreenSize(context).heightOnly( 0.7),),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 2.8)),
                          child: SizedBox(
                            width: double.infinity,
                            child: RichText(
                              text: TextSpan(
                                  text: approvalResultSet?[index].screenName??'',
                                  style: GetFont.get(
                                      context,
                                      fontSize: 1.6,
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.colorGrey3
                                  ),
                                  children: [
                                    TextSpan(
                                      text:' ${CallLanguageKeyWords.get(context, LanguageCodes.approvalKey)} ',
                                      style: GetFont.get(
                                          context,
                                          fontSize: 1.6,
                                          fontWeight: FontWeight.w400,
                                          color: MyColor.colorGrey3
                                      ),
                                    ),
                                    TextSpan(
                                      text:approvalResultSet?[index].orignatorUserName??'',
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          );
        },
        separatorBuilder: (context,index){
          return SizedBox(height: ScreenSize(context).heightOnly( 2),);
        },
        itemCount: approvalResultSet?.length??0);
  }

}
