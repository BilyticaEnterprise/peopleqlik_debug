import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';
import 'package:store_redirect/store_redirect.dart';

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({Key? key}) : super(key: key);

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
                title: AppBarWidget("${CallLanguageKeyWords.get(context, LanguageCodes.accountSettingHeader)}")

            ),
          ];
        },
        body: Consumer<CheckInternetConnection>(
            builder: (context,data,child) {
              if(data.internetConnectionEnum == InternetConnectionEnum.available)
              {
                return BodyData();

              }
              else
              {
                return NotAvailable(GetVariable.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
              }
            }
        ),
      ),
    );
  }
}
class BodyData extends StatelessWidget {
  BodyData({Key? key}) : super(key: key);

  final colors = [MyColor.colorA1,
    MyColor.colorA1,
    // ,0xffF1F1F3
  ];
  final icons = [MdiIcons.arrowUpDownBoldOutline,
    MdiIcons.officeBuilding,
    ];
  @override
  Widget build(BuildContext context) {
    final header = ['${CallLanguageKeyWords.get(context, LanguageCodes.accountUpdatesHeader)}',
      '${CallLanguageKeyWords.get(context, LanguageCodes.changeCompanyHeader)}'
      ];
    final answer = [
      '${CallLanguageKeyWords.get(context, LanguageCodes.accountUpdatesAnswer)} ',
      '${CallLanguageKeyWords.get(context, LanguageCodes.changeCompanyValue)}'
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 6.6),ScreenSize(context).heightOnly( 2),ScreenSize(context).widthOnly( 6.6),ScreenSize(context).heightOnly( 15)),
            itemBuilder: (context,index){
              return Container(
                decoration: BoxDecoration(
                  color: const Color(MyColor.colorWhite),
                  borderRadius: const BorderRadius.all(Radius.circular(20),),
                  border: Border.all(
                      width: 0.7,
                      color: const Color(MyColor.colorBlack)
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20),),
                  child: Material(
                    color: const Color(MyColor.colorTransparent),
                    child: InkWell(
                      splashColor: const Color(MyColor.colorGreyPrimary),
                      onTap: () async {
                        switch(index)
                        {
                          case 0:
                            StoreRedirect.redirect(androidAppId: "com.bilytica.peopleqlik_debug",
                                iOSAppId: "1605562991");
                            break;
                          case 1:
                            Navigator.pushNamed(context, CurrentPage.ChangeCompanyPage);
                            break;
                          default:
                            break;
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly( 2)),
                        child: Row(
                          children: [
                            Container(
                                height: ScreenSize(context).heightOnly( 4.2),
                                width: ScreenSize(context).heightOnly( 4.2),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10),),
                                  color: Color(colors[index]),
                                ),
                                child: Icon(icons[index],color: const Color(MyColor.colorBlack),size: ScreenSize(context).heightOnly( 2.4),)
                            ),
                            SizedBox(width: ScreenSize(context).heightOnly( 1.4),),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      header[index],
                                      style: GetFont.get(
                                          context,
                                          fontSize:1.5,
                                          fontWeight: FontWeight.w600,
                                          color: MyColor.colorBlack
                                      ),
                                    ),
                                    SizedBox(height: ScreenSize(context).heightOnly( 0.5),),
                                    Text(
                                      index==0?'${answer[index]} ${Provider.of<SettingsModelListener>(context).packageInfo?.version} (${Provider.of<SettingsModelListener>(context).packageInfo?.buildNumber})':answer[index],
                                      style: GetFont.get(
                                          context,
                                          fontSize:1.2,
                                          fontWeight: FontWeight.w400,
                                          color: MyColor.colorGrey4
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            // SizedBox(
                            //     height: ScreenSize(context).heightOnly( 2.5),
                            //     width: ScreenSize(context).heightOnly( 2.5),
                            //     child: Icon(Icons.arrow_forward_ios,color: const Color(MyColor.colorBlack),size: ScreenSize(context).heightOnly( 2.2),)
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context,index){
              return SizedBox(
                height: ScreenSize(context).heightOnly( 2),
              );
            },
            itemCount: header.length),
      ],
    );
  }
}
