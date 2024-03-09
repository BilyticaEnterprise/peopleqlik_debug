import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/NotifcationsListeners/announcements_detail_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/FileDownloaderListener/file_downloader_listener.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/Announcements/AnnouncementPanels/panel_body.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/Announcements/AnnouncementPanels/panel_header.dart';
import 'package:peopleqlik_debug/utils/Buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/ScreenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/Webview_Html_Widget/html_widget.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../configs/get_assets.dart';
import '../../../../../utils/Appbars/app_bar.dart';

class AnnouncementDetailPage extends StatefulWidget {
  AnnouncementDetailPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementDetailPage> createState() => _AnnouncementDetailPageState();
}

class _AnnouncementDetailPageState extends State<AnnouncementDetailPage> {
  PanelController panelController = PanelController();

  String? code;

  @override
  Widget build(BuildContext context) {

    code = ModalRoute.of(context)!.settings.arguments as String;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GetAnnouncementDetailListener>(create: (_) => GetAnnouncementDetailListener()),
          ChangeNotifierProvider<FileDownloaderListener>(create: (_) => FileDownloaderListener()),
        ],
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: const Color(MyColor.colorWhite),
            body: SlidingUpPanel(
              maxHeight: ScreenSize(context).heightOnly(90),
              minHeight: 0,
              isDraggable: false,
              panelSnapping: true,
              defaultPanelState: PanelState.CLOSED,
              controller: panelController,
              parallaxEnabled: true,
              backdropEnabled: true,
              backdropColor: const Color(MyColor.colorGreySecondary),
              header: PanelHeader(panelController),
              parallaxOffset: .5,
              panelBuilder: (sc) => PanelHeaderAnnouncement(panelController),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
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
                        title: AppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.announcementAppBar)}')
                    ),
                  ];
                },
                body: Consumer<CheckInternetConnection>(
                    builder: (context, data, child) {
                      if (data.internetConnectionEnum ==
                          InternetConnectionEnum.available) {
                        return  BodyData(code,panelController);
                      }
                      else {
                        return NotAvailable(
                          GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}',
                          '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}', topMargin: 8,
                          width: 50,
                          height: 24,);
                      }
                    }
                ),
              ),
            ),

          );
        }
    );
  }
}
class BodyData extends StatefulWidget {
  final String? code;
  final PanelController panelController;
  const BodyData(this.code, this.panelController, {Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<GetAnnouncementDetailListener>(context,listen: false).start(context, widget.code!);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetAnnouncementDetailListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done|| data.apiStatus == ApiStatus.pagination)
          {
            return SizedBox(
              height: ScreenSize(context).heightOnly( 100),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: ScreenSize(context).heightOnly( 1),),
                        if(data.pictures!=null&&data.pictures!.isNotEmpty)
                          ...[
                            SizedBox(
                              height: ScreenSize(context).heightOnly( 24),
                              child: Swiper(
                                itemHeight: ScreenSize(context).heightOnly( 10),
                                autoplay: true,
                                itemBuilder: (BuildContext context, int indexYe) {
                                  //PrintLogs.print('${RequestType.fileUrl}${data.pictures?[indexYe]}');
                                  return CachedNetworkImage(
                                      imageUrl: '${RequestType.attachmentsUrl}${data.pictures?[indexYe]}',
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
                                  Navigator.pushNamed(context, CurrentPage.ProductImageZoom,arguments: '${RequestType.attachmentsUrl}${data.pictures?[pos]}');
                                },
                                itemCount: data.pictures!.length,
                                viewportFraction: 0.75,
                                scale: 0.85,
                              ),
                            ),
                            SizedBox(height: ScreenSize(context).heightOnly( 2),),
                          ],
                        if(data.pictures==null||data.pictures!.isEmpty)...[
                          Text(
                            data.getAnnouncementDetailResultSet?.title??'',
                            style: GetFont.get(
                                context,
                                fontWeight: FontWeight.w600,
                                fontSize: 2.2,
                                color: MyColor.colorBlack
                            ),
                          ),
                          SizedBox(height: ScreenSize(context).heightOnly( 2),),
                        ],
                        Flexible(
                          fit: FlexFit.loose,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 3.6)),
                              child: HtmlDetailWidget(data.getAnnouncementDetailResultSet?.description)
                          ),
                        ),
                        SizedBox(height: ScreenSize(context).heightOnly( window.viewPadding.bottom>0?16:18),),
                      ],
                    ),
                  ),
                  if(data.getAnnouncementDetailResultSet?.admAnnouncementDocument!=null&&data.getAnnouncementDetailResultSet!.admAnnouncementDocument!.isNotEmpty)...[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly( window.viewPadding.bottom>0?3:5)),
                        child: ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.AttachmentButton)}',buttonColor: MyColor.colorBlack,textSize: 2.0,textColor: MyColor.colorWhite,height: 6.5,paddingHorizontal: ScreenSize(context).heightOnly( 4.2),width: ScreenSize(context).widthOnly( 90),weight: FontWeight.w600,onPressed: openPanelPressed,),
                      ),
                    )
                  ]
                ],
              )
            );
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr23)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringSStr46)}',topMargin: 8,width: 40,);
          }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr10)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
  openPanelPressed() async
  {
    await widget.panelController.open();
  }
}

