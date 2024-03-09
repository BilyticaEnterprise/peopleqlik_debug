import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestDetails/request_detail_listener.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_rejection_page.dart';
import 'package:peopleqlik_debug/utils/ScreenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/lottie_anims_utils/lottie_string.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../../../configs/get_assets.dart';
import '../../../../../../utils/Appbars/app_bar.dart';
import '../../ApprovalsSubPages/ApprovalsAcceptance/CommonWidgets/approval_list_widget.dart';
import 'request_list_sub_page.dart';

class RequestDetailPage extends StatelessWidget {
  RequestDetailData? requestDetailData;
  RequestDetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    requestDetailData = ModalRoute.of(context)!.settings.arguments as RequestDetailData;
    return Scaffold(
        backgroundColor: const Color(MyColor.colorWhite),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(MyColor.colorWhite),
          toolbarHeight: 0,
        ),
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
                  title: AppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.requestsDetail)}')
              ),
            ];
          },
          body: Consumer<CheckInternetConnection>(
              builder: (context,data,child) {
                if(data.internetConnectionEnum == InternetConnectionEnum.available)
                {
                  return ChangeNotifierProvider<GetRequestDetailListener>(
                      create: (_) => GetRequestDetailListener(),
                      builder: (context, snapshot) {
                        return BodyData(requestDetailData);
                      }
                  );
                }
                else
                {
                  return NotAvailable(GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
                }
              }
          ),
        )
    );
  }
}
class BodyData extends StatefulWidget {
  final RequestDetailData? requestDetailData;
  const BodyData(this.requestDetailData, {Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetRequestDetailListener>(context,listen: false).start(context, widget.requestDetailData?.requestCode, widget.requestDetailData?.managerId);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetRequestDetailListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return BodyDataNow(data);
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableH)}', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableA)}',topMargin: 8,width: 30);
          }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableH)}', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableA)}',topMargin: 8,width: 30);
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
  final GetRequestDetailListener data;
  const BodyDataNow(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize(context).heightOnly( 100),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(data.requestNamesResultSet!=null&&data.requestNamesResultSet!.isNotEmpty&&data.requestNamesResultSet?[0].admRequestFile!=null&&data.requestNamesResultSet![0].admRequestFile!.isNotEmpty)...[
              SizedBox(
                height: ScreenSize(context).heightOnly( 24),
                child: Swiper(
                  itemHeight: ScreenSize(context).heightOnly( 10),
                  autoplay: true,
                  itemBuilder: (BuildContext context, int indexYe) {
                    //PrintLogs.print('${RequestType.requestUrl}${data.requestNamesResultSet?[0].admRequestFile?[indexYe].fileName}');
                    return CachedNetworkImage(
                        imageUrl: '${RequestType.requestUrl}${data.requestNamesResultSet?[0].admRequestFile?[indexYe].fileName}',
                        imageBuilder: (context, imageProvider) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color(MyColor.colorWhite),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(MyColor.colorWhite),
                            borderRadius: BorderRadius.all(Radius.circular(15)),

                          ),
                          child: const ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              child: Center(child: CircularProgressIndicator())
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(MyColor.colorGrey0),
                              borderRadius: BorderRadius.all(Radius.circular(15)),

                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              child: Image.asset('assets/logo.png',fit: BoxFit.fitWidth,
                              ),
                            )
                        )
                    );
                  },
                  onTap: (pos){
                    Navigator.pushNamed(context, CurrentPage.ProductImageZoom,arguments: '${RequestType.requestUrl}${data.requestNamesResultSet?[0].admRequestFile?[pos].fileName}');
                  },
                  itemCount: data.requestNamesResultSet?[0].admRequestFile?.length??0,
                  viewportFraction: 0.75,
                  scale: 0.85,
                ),
              ),
              SizedBox(height: ScreenSize(context).heightOnly( 2),)
            ],
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly( 4)),
                itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: const Color(MyColor.colorBackgroundDark),
                            width: 0.7
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              data.requestNamesResultSet?[0].admRequestValue?[index].admRequestManagerDt?.title??'${CallLanguageKeyWords.get(context, LanguageCodes.File)} ${index+1}',
                              style: GetFont.get(
                                  context,
                                  fontSize:1.8,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.colorBlack
                              ),
                          ),
                          SizedBox(height: ScreenSize(context).widthOnly( 2),),
                          Flexible(
                            flex:0,
                            child: Text(
                              data.requestNamesResultSet?[0].admRequestValue?[index].controlValue??'',
                              style: GetFont.get(
                                  context,
                                  fontSize:1.8,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorBlack
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context,index){return SizedBox(height: ScreenSize(context).heightOnly( 2),);},
                itemCount: data.requestNamesResultSet?[0].admRequestValue?.length??0
            ),
            if(data.uniqueList!=null&&data.uniqueList!.isNotEmpty&&data.approvalsList!=null&&data.approvalsList!.isNotEmpty)...
            [
              SizedBox(height: ScreenSize(context).heightOnly( 2),),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                child: Text(
                  '${CallLanguageKeyWords.get(context, LanguageCodes.ApprovalHistory)}',
                  style: GetFont.get(
                      context,
                      fontWeight: FontWeight.w700,
                      fontSize: 2.2,
                      color: MyColor.colorBlack
                  ),
                ),
              ),
              SizedBox(height: ScreenSize(context).heightOnly( 1.5),),
              Flexible(
                //fit: FlexFit.loose,
                  flex: 1,
                  child: ApprovalListWidget(data.approvalsList)
              ),
              DividerByHeight(10)
            ],
            
          ],
        ),
      ),
    );
  }
}


