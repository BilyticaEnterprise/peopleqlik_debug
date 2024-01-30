import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import '../../Reuse_LogicalWidgets/tick_icon.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LanguageData(),
        builder: (context, snapshot) {
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
                        title: Consumer<ChangeLanguage>(
                          builder: (context, data,child) {
                            return AppBarWidget("${CallLanguageKeyWords.get(context, LanguageCodes.languageAppbar)}");
                          }
                        )
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
      Provider.of<LanguageData>(context,listen: false).setData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageData>(
      builder: (context,langData,child) {
        return Consumer<ChangeLanguage>(
          builder: (context,data,child) {
            return ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 6.6),0,ScreenSize(context).widthOnly( 6.6),ScreenSize(context).heightOnly( 15) ),
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
                                data.checkLanguageStatus(context,langData.languageList?[index].cultureID??1);
                                break;
                              case 1:
                                data.checkLanguageStatus(context,langData.languageList?[index].cultureID??2);
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
                                      color: Color(langData.colors[index]),
                                    ),
                                    child: Icon(langData.icons[index],color: const Color(MyColor.colorBlack),size: ScreenSize(context).heightOnly( 2.4),)
                                ),
                                SizedBox(width: ScreenSize(context).heightOnly( 1.4),),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          langData.languageList?[index].displayName??'',
                                          style: GetFont.get(
                                              context,
                                              languageEnum: index==1?LanguageEnum.arabic:LanguageEnum.english,
                                              fontSize:1.5,
                                              fontWeight: FontWeight.w600,
                                              color: MyColor.colorBlack
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                TickIcon(check: data.selected[index]==true?true:false,),
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
                itemCount: langData.languageList?.length??0);
          }
        );
      }
    );
  }
}
