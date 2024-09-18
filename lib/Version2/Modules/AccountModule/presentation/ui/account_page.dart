import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/presentation/listeners/account_page_info_listener.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/utils/SkeletetonAnimation/skeleton_text.dart';
import '../listeners/image_get_listener.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AccountPageInfoListener>(create: (_) => AccountPageInfoListener(),)
      ],
      child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            const SliverToBoxAdapter(
              child: TopWidget(),
            ),
            SliverToBoxAdapter(
              child: BottomWidget(),
            )
          ],
      ),
    );
  }
}
class TopWidget extends StatefulWidget {
  const TopWidget({Key? key}) : super(key: key);

  @override
  _TopWidgetState createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AccountPageInfoListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountPageInfoListener>(
      builder: (context,data,child) {

        return Container(
            width: double.infinity,
            height: ScreenSize(context).heightOnly( 34),
            color: const Color(MyColor.colorWhite),
            child: Column(
              children: [
                Container(
                  width: ScreenSize(context).heightOnly(20.0),
                  height: ScreenSize(context).heightOnly(20.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(52)),
                    color: const Color(MyColor.colorWhite),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(MyColor.colorGrey0).withOpacity(0.6),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                      BoxShadow(
                        color: const Color(MyColor.colorGreySecondary).withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(-3, -3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(52)),
                    child: Material(
                      color: const Color(MyColor.colorWhite),
                      child: InkWell(
                        splashColor: const Color(MyColor.colorPrimary),
                        onTap: (){
                          //Provider?.of<GetImage>(context,listen: false).getImageFromGallery();
                        },
                        child: Center(
                          child: Consumer<GetImage>(
                              builder: (context,imageData,child) {
                                if(imageData.imageGetterEnums == ImageGetterEnums.nothing||imageData.imageGetterEnums == ImageGetterEnums.urlImage)
                                {
                                  return CachedNetworkImage(
                                    imageUrl: "${RequestType.profileUrl}${data.image}",
                                    imageBuilder: (context, imageProvider) => Container(
                                      width: ScreenSize(context).heightOnly(18),
                                      height: ScreenSize(context).heightOnly(18),
                                      margin: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.all(Radius.circular(45)),
                                          color: const Color(MyColor.colorWhite),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(MyColor.colorGrey2).withOpacity(0.6),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3), // changes position of shadow
                                            ),
                                            BoxShadow(
                                              color: const Color(MyColor.colorGrey0).withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(-3, -3), // changes position of shadow
                                            ),
                                          ],
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover
                                          )

                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                      width: ScreenSize(context).heightOnly(18),
                                      height: ScreenSize(context).heightOnly(18),
                                      margin: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.all(Radius.circular(45)),
                                        color: const Color(MyColor.colorWhite),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(MyColor.colorGrey2).withOpacity(0.6),
                                            spreadRadius: 4,
                                            blurRadius: 6,
                                            offset: const Offset(0, 3), // changes position of shadow
                                          ),
                                          BoxShadow(
                                            color: const Color(MyColor.colorGrey0).withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(-3, -3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(45)),
                                          child: SkeletonAnimation(
                                            shimmerColor:const Color(MyColor.colorGrey0).withOpacity(0.2),
                                            gradientColor:const Color.fromARGB(0, 244, 244, 244),
                                            curve:Curves.easeInOutSine,
                                            child: const SizedBox(
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          )
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      width: ScreenSize(context).heightOnly(18),
                                      height: ScreenSize(context).heightOnly(18),
                                      margin: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
                                      padding: EdgeInsets.all(ScreenSize(context).heightOnly(1.2)),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.all(Radius.circular(45)),
                                        color: const Color(MyColor.colorGrey6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(MyColor.colorGrey2).withOpacity(0.6),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3), // changes position of shadow
                                          ),
                                          BoxShadow(
                                            color: const Color(MyColor.colorGrey0).withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(-3, -3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(45)),
                                        child: Image.asset('assets/avatar_profile.png',fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                else
                                {
                                  return Container(
                                    width: ScreenSize(context).heightOnly(16),
                                    height: ScreenSize(context).heightOnly(16),
                                    margin: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: const BorderRadius.all(Radius.circular(45)),
                                      color: const Color(MyColor.colorWhite),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(MyColor.colorGrey2).withOpacity(0.6),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3), // changes position of shadow
                                        ),
                                        BoxShadow(
                                          color: const Color(MyColor.colorGrey0).withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(-3, -3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(45)),
                                      child: Image.file(
                                        imageData.image,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }
                              }
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenSize(context).heightOnly( 3),),
                Text(
                  data.userName??'${CallLanguageKeyWords.get(context, LanguageCodes.accountUsername)}',
                  style: GetFont.get(
                      context,
                      fontSize: 2.2,
                      color: MyColor.colorBlack,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: ScreenSize(context).heightOnly( 2),),
                Text(
                  data.designation??"${CallLanguageKeyWords.get(context, LanguageCodes.accountDesign)}",
                  style: GetFont.get(
                      context,
                      fontSize: 1.5,
                      color: MyColor.colorDarkBrown,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
        );
      }
    );
  }
}
class BottomWidget extends StatefulWidget {
  BottomWidget({Key? key}) : super(key: key);

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {

  @override
  Widget build(BuildContext context) {


    return Consumer<AccountPageInfoListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done)
            {
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
                              data.clickedIndex(context,index);
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
                                        color: Color(data.accountModel[index].color),
                                      ),
                                      child: Icon(data.accountModel[index].icon,color: const Color(MyColor.colorBlack),size: ScreenSize(context).heightOnly( 2.4),)
                                  ),
                                  SizedBox(width: ScreenSize(context).heightOnly( 1.4),),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.accountModel[index].header,
                                            style: GetFont.get(
                                                context,
                                                fontSize:1.5,
                                                fontWeight: FontWeight.w600,
                                                color: MyColor.colorBlack
                                            ),
                                          ),
                                          SizedBox(height: ScreenSize(context).heightOnly( 0.5),),
                                          Text(
                                            data.accountModel[index].desc,
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
                                  SizedBox(
                                      height: ScreenSize(context).heightOnly( 2.5),
                                      width: ScreenSize(context).heightOnly( 2.5),
                                      child: Icon(Icons.arrow_forward_ios,color: const Color(MyColor.colorBlack),size: ScreenSize(context).heightOnly( 2.2),)
                                  ),
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
                  itemCount: data.accountModel.length);
            }
          else
            {
              return Container(height: 0,);
            }
      }
    );
  }
}

