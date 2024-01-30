import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/FileDownloaderListener/file_downloader_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/NotifcationsListeners/announcements_detail_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/Announcements/AnnouncementPanels/permission_page.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Buttons/buttons.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/src/panel.dart';

class PanelHeaderAnnouncement extends StatefulWidget {
  PanelController panelController;
  PanelHeaderAnnouncement(this.panelController, {Key? key}) : super(key: key);

  @override
  State<PanelHeaderAnnouncement> createState() => _PanelHeaderAnnouncementState();
}

class _PanelHeaderAnnouncementState extends State<PanelHeaderAnnouncement> {

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<FileDownloaderListener>(context,listen: false).stater();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<FileDownloaderListener>(
      builder: (context,data,child) {
        if (data.storageEnum == StorageEnum.success) {
          return ListToDownLoad(data);
        }
        else if (data.storageEnum == StorageEnum.goToSettings) {
          return StoragePermission(widget.panelController);
        }
        else if (data.storageEnum == StorageEnum.permission) {
          return StoragePermission(widget.panelController);
        }
        else
          {
            return const CircularIndicatorCustomized();
          }
      }
    );
  }
}
class ListToDownLoad extends StatelessWidget {
  final FileDownloaderListener fileDownloaderListener;
  const ListToDownLoad(this.fileDownloaderListener, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GetAnnouncementDetailListener>(
      builder: (context, data,child) {
        return ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 9),bottom: ScreenSize(context).heightOnly( 8)),
            itemBuilder: (context,index)
            {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(
                        width: 1,
                        color: const Color(MyColor.colorGrey7)
                    )
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Material(
                    color: const Color(MyColor.colorTransparent),
                    child: InkWell(
                      splashColor: const Color(MyColor.colorGrey7),
                      onTap: (){
                        fileDownloaderListener.downLoad(context,data.getAnnouncementDetailResultSet?.admAnnouncementDocument?[index].fileName);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${CallLanguageKeyWords.get(context, LanguageCodes.File)} ${index+1}',
                                    style: GetFont.get(
                                        context,
                                        fontSize:1.8,
                                        fontWeight: FontWeight.w600,
                                        color: MyColor.colorBlack
                                    ),
                                  ),
                                ),
                                Icon(
                                  MdiIcons.download,
                                  size: ScreenSize(context).heightOnly( 2),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }, separatorBuilder: (context,index){
              return SizedBox(
                height: ScreenSize(context).heightOnly( 2),
              );
        }, itemCount: data.getAnnouncementDetailResultSet?.admAnnouncementDocument?.length??0);
      }
    );
  }
}

