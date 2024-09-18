import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/FileDownloaderListener/file_downloader_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Payslips/payslip_month_listener.dart';
import 'package:peopleqlik_debug/Version1/models/PaysSlipApprovalsRequest/get_payslip_list.dart';
import 'package:peopleqlik_debug/Version1/models/PaysSlipApprovalsRequest/get_payslip_month.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/PayslipPages/PaySlipWidget/circle_widget.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/PayslipPages/PaySlipWidget/payslip_curve.dart';
import '../../../../../configs/get_assets.dart';
import '../../../../../utils/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

class PaySlipMonthPage extends StatelessWidget {
  PaySlipMonthPage({Key? key}) : super(key: key);
  GetPaySlipDataList? getPaySlipDataList;

  @override
  Widget build(BuildContext context) {
    getPaySlipDataList = ModalRoute.of(context)!.settings.arguments as GetPaySlipDataList;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PayslipMonthModelListener>(create: (_) => PayslipMonthModelListener()),
        ChangeNotifierProvider<FileDownloaderListener>(create: (_) => FileDownloaderListener()),

      ],
      child: Scaffold(
        backgroundColor: const Color(MyColor.colorWhite),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: false,
                  floating: true,
                  backgroundColor: const Color(MyColor.colorPrimary).withOpacity(1),
                  snap: true,
                  elevation: 2,
                  titleSpacing: 0,
                  title: AppBarWidget('',color: MyColor.colorWhite,)
              ),
            ];
          },
          body: Consumer<CheckInternetConnection>(
              builder: (context,data,child) {
                if(data.internetConnectionEnum == InternetConnectionEnum.available)
                {
                  return BodyData(getPaySlipDataList);
                }
                else
                {
                  return NotAvailable(GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
                }
              }
          ),
        ),

      ),
    );
  }
}
class BodyData extends StatefulWidget {
  final GetPaySlipDataList? getPaySlipDataList;
  const BodyData(this.getPaySlipDataList, {Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<PayslipMonthModelListener>(context,listen: false).start(context, widget.getPaySlipDataList!.periodCode!);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<PayslipMonthModelListener>(
          builder: (context,data,snapshot) {
            if(data.apiStatus == ApiStatus.done)
            {
              return Column(
                children: [
                  TopWidget(data,widget.getPaySlipDataList),
                  BottomWidget(data,widget.getPaySlipDataList)
                ],
              );
            }
            else if(data.apiStatus == ApiStatus.empty)
            {
              return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr19)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr20)}',topMargin: 8,width: 40,);
            }
            else if(data.apiStatus == ApiStatus.error)
            {
              return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
            }
            else
            {
              return const CircularIndicatorCustomized(marginBottom: 0,marginTop: 4,size: 10,);
            }

          }
      ),
    );
  }
}
class TopWidget extends StatelessWidget {
  final PayslipMonthModelListener? data;
  final GetPaySlipDataList? getPaySlipDataList;
  const TopWidget(this.data, this.getPaySlipDataList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height/100*32;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      height: _height,
      width: _width,
      child: CustomPaint(
        painter: CurvePainter(color: const Color(MyColor.colorPrimary).withOpacity(1)),
        child: Column(
          children: [
            SizedBox(width: ScreenSize(context).heightOnly( 0.8),),
            Text(
              '${getPaySlipDataList?.periodTitle}',
              style: GetFont.get(
                  context,
                  fontSize: 2.4,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorWhite
              ),
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 3),),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.paySlipmonthPageEarnings)}',
                        style: GetFont.get(
                            context,
                            fontSize: 1.6,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorGrey0
                        ),
                      ),
                      SizedBox(height: ScreenSize(context).heightOnly( 1),),
                      Text(
                        '${data?.earningSalary}',
                        style: GetFont.get(
                            context,
                            fontSize: 3.2,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorWhite
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: _height/100*24,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(MyColor.colorWhite)
                  ),

                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.paySlipmonthPageDeduction)}',
                        style: GetFont.get(
                            context,
                            fontSize: 1.6,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorGrey0
                        ),
                      ),
                      SizedBox(height: ScreenSize(context).heightOnly( 1),),
                      Text(
                        '${data?.deductionsSalary}',
                        style: GetFont.get(
                            context,
                            fontSize: 3.2,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorWhite
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 2),),
            ClipOval(
              child: Material(
                color: const Color(MyColor.colorPrimary),
                child: InkWell(
                  splashColor: const Color(MyColor.colorGrey0),
                  onTap: (){
                    PrintLogs.printLogs('uuuuu ${jsonEncode(data?.getPaySlipResultSet)}');
                    if(getPaySlipDataList?.quickPayrollReasonID==0)
                      {
                        String url = '${RequestType.fileUrl}Employee/${getPaySlipDataList?.employeeCode}/${getPaySlipDataList?.periodCode}_${getPaySlipDataList?.quickPayrollReasonID==0?"Regular":""}.pdf';
                        Provider.of<FileDownloaderListener>(context,listen: false).downLoad(context, url);
                      }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.2)),
                    child: SvgPicture.string(
                      SvgPicturesData.download,
                      width: ScreenSize(context).heightOnly( 5),
                      height: ScreenSize(context).heightOnly( 5),
                      color: const Color(MyColor.colorWhite),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox(height: ScreenSize(context).heightOnly( 3),)),
            Text(
              '${CallLanguageKeyWords.get(context, LanguageCodes.paySlipmonthPageDetail)}',
              style: GetFont.get(
                  context,
                  fontSize: 1.6,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorGrey3
              ),
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 3))
          ],
        ),
      ),
    );
  }
}
class BottomWidget extends StatelessWidget {
  final PayslipMonthModelListener? data;
  final GetPaySlipDataList? getPaySlipDataList;
  const BottomWidget(this.data, this.getPaySlipDataList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context,index)
        {
          return Container(
            padding: EdgeInsets.all(ScreenSize(context).heightOnly( 2)),
            margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: const Color(MyColor.colorWhite),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 0.0,
                    blurRadius: 10,
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
            child: Row(
              children: [
                Container(
                  width: ScreenSize(context).heightOnly( 1.5),
                  height: ScreenSize(context).heightOnly( 1.5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(getColor(index == data!.getPaySlipResultSet!.length?-1:data?.getPaySlipResultSet?[index].elementTypeID)!)
                  ),
                ),
                Container(
                  height: ScreenSize(context).heightOnly( 4),
                  color: const Color(MyColor.colorBackgroundDark),
                  width: 1,
                  margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 2)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        index == data!.getPaySlipResultSet!.length?'${CallLanguageKeyWords.get(context, LanguageCodes.paySlipmonthPageTotal)}':data?.getPaySlipResultSet?[index].elementTitle??'',
                        style: GetFont.get(
                            context,
                            fontSize: 1.8,
                            fontWeight: index == data!.getPaySlipResultSet!.length?FontWeight.w600:FontWeight.w400,
                            color: MyColor.colorBlack
                        ),
                      ),
                      if(index != data!.getPaySlipResultSet!.length)...[
                        SizedBox(height: ScreenSize(context).widthOnly( 0.5),),
                        Text(
                          data?.getPaySlipResultSet?[index].elementDesc??'',
                          style: GetFont.get(
                              context,
                              fontSize: 1.4,
                              fontWeight: FontWeight.w400,
                              color: index == data!.getPaySlipResultSet!.length?MyColor.colorBlack:MyColor.colorGrey3
                          ),
                        ),
                      ],

                    ],
                  )
                ),
                SizedBox(width: ScreenSize(context).widthOnly( 2),),
                Text(
                  '${index == data!.getPaySlipResultSet!.length?data?.total:data?.getPaySlipResultSet?[index].amount}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.8,
                      fontWeight: FontWeight.w600,
                      color: MyColor.colorBlack
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context,index)
        {
          return SizedBox(height: ScreenSize(context).heightOnly( 2),);
        },
        itemCount: data?.getPaySlipResultSet!=null&&data!.getPaySlipResultSet!.isNotEmpty?data!.getPaySlipResultSet!.length+1:0

    );
  }
  int? getColor(int? type)
  {
    switch(type)
    {
      case 1:
        return MyColor.colorClockIn;
      case 3:
        return MyColor.colorClockIn;
      case 4:
        return MyColor.colorClockIn;
      case -1:
        return MyColor.colorBlack;
      default:
        return MyColor.colorClockOut;
    }
  }
}