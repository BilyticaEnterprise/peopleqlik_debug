import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Payslips/payslip_list_listener.dart';
import 'package:peopleqlik_debug/Version1/models/PaysSlipApprovalsRequest/get_payslip_list.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/lottie_anims_utils/lottie_string.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';
import '../../../../../configs/get_assets.dart';
import '../../../../../utils/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/utils/SkeletetonAnimation/skeleton_text.dart';

class PayslipPage extends StatefulWidget {
  const PayslipPage({Key? key}) : super(key: key);

  @override
  _PayslipPageState createState() => _PayslipPageState();
}

class _PayslipPageState extends State<PayslipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(MyColor.colorWhite),
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: false,
                    floating: true,
                    backgroundColor: const Color(MyColor.colorWhite),
                    snap: true,
                    elevation: 2,
                    titleSpacing: 0,
                    title: AppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.paySlipPaySlips)}')
                ),
              ];
            },
            body: Consumer<CheckInternetConnection>(
                builder: (context,data,child) {
                  if(data.internetConnectionEnum == InternetConnectionEnum.available)
                  {
                    return const BodyData();
                  }
                  else
                  {
                    return NotAvailable(GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
                  }
                }
            ),
          ),

    );
  }
}
class BodyData extends StatefulWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PayslipListModelListener>(context,listen: false).start(context, ApiStatus.started);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<PayslipListModelListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done|| data.apiStatus == ApiStatus.pagination)
          {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification){
                PayslipListModelListener payslipListModelListener = Provider.of<PayslipListModelListener>(context,listen: false);
                // PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                {
                  // PrintLogs.print('true');
                  payslipListModelListener.updateStep(true, context);
                  return true;
                }
                else
                {
                  payslipListModelListener.updateStep(false, context);
                  return false;
                }
              },
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 2),bottom: ScreenSize(context).heightOnly( 10)),
                  itemBuilder: (context,index)
                  {
                    return PaySlipWidget(data.dataList?[index],index);
                  },
                  separatorBuilder: (context,index)
                  {
                    return SizedBox(height: ScreenSize(context).heightOnly( 2),);
                  },
                  itemCount: data.dataList?.length??0
              ),
            );
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable(LottieString.notAvailable, '${CallLanguageKeyWords.get(context, LanguageCodes.noInfoAvailableHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.noInfoIsAvailableValue)}',topMargin: 8,width: 40,);
          }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
}
class PaySlipWidget extends StatelessWidget {
  final int? index;
  final GetPaySlipDataList? paySlipDataList;
  const PaySlipWidget(this.paySlipDataList,this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<PayslipListModelListener>(context,listen: false).reachedEnd&&index==Provider.of<PayslipListModelListener>(context,listen: false).dataList!.length-1?
    Container(
      height: ScreenSize(context).heightOnly( 12),
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
              width: 1,
              color: const Color(MyColor.colorBackgroundDark)
          )
      ),
      child: SkeletonAnimation(
          key: Key('requestShimmer$index'),
          shimmerColor:Colors.white70,
          gradientColor:const Color(MyColor.colorGreyPrimary).withOpacity(0.2),
          curve:Curves.fastOutSlowIn, child: Container()),
    ):Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
              color: const Color(MyColor.colorBackgroundDark),
              width: 0.7
          )
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Material(
          color: const Color(MyColor.colorWhite),
          child: InkWell(
            splashColor: const Color(MyColor.colorGrey0),
            onTap: (){
              Navigator.pushNamed(context, CurrentPage.PaySlipMonthPage, arguments: paySlipDataList);
            },
            child: Padding(
                padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            GetDateFormats().getFilterDate(paySlipDataList?.periodDate)??'',
                            style: GetFont.get(
                                context,
                                fontSize: 1.6,
                                fontWeight: FontWeight.w400,
                                color: MyColor.colorGrey3
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenSize(context).widthOnly( 2),),
                        Text(
                          paySlipDataList?.periodTitle??'',
                          style: GetFont.get(
                              context,
                              fontSize: 1.6,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 0.3),),
                    Flexible(
                      child: Text(
                        paySlipDataList?.calendarTitle??'',
                        style: GetFont.get(
                            context,
                            fontSize: 1.8,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorBlack
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 0.3),),
                    Row(
                      children: [
                        Text(
                          paySlipDataList?.employeeName??'',
                          style: GetFont.get(
                              context,
                              fontSize: 1.4,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorGrey3
                          ),
                        ),
                        SizedBox(width: ScreenSize(context).heightOnly( 0.3),),
                        Text(
                          paySlipDataList?.displayName??'',
                          style: GetFont.get(
                              context,
                              fontSize: 1.4,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorGrey3
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 1.2),),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            paySlipDataList?.quickPayrollReason??'',
                            style: GetFont.get(
                                context,
                                fontSize: 1.4,
                                fontWeight: FontWeight.w400,
                                color: getColor(paySlipDataList?.quickPayrollReasonID)
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: ScreenSize(context).heightOnly( 1.8),
                          color: const Color(MyColor.colorBlack),
                        )
                      ],
                    )
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
  int? getColor(int? quickPayrollReasonID)
  {
    switch(quickPayrollReasonID)
    {
      case 0:
        return MyColor.colorPrimary;
      case 1:
        return MyColor.colorSecondary;
      default:
        return MyColor.colorPrimary;
    }
  }
}
