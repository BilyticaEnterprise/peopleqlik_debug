import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../Version1/viewModel/LanguageListeners/language_listener.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../utils/tabs/domain/model/tab_bar_data.dart';
import '../../../utils/options_list.dart';

class EditDialogView
{
  static show(BuildContext context,Function(int?) onDone)
  {
    showDialog(
        context: context,
        barrierColor: Colors.black38,
        barrierDismissible: true,
        builder: (BuildContext dialogContext)=>
            Localizations.override(
                context: context,
                locale: Provider.of<ChangeLanguage>(context,listen: false).languageEnum==LanguageEnum.arabic?Locale('ar','SA'):Locale('en','US'),
                child: ProfileEditDialogList())
    ).then((value){
      onDone(value);
    });
  }
}

class ProfileEditDialogList extends StatelessWidget {
  const ProfileEditDialogList({super.key});

  @override
  Widget build(BuildContext context) {
    List<TabOptionData> list = ProfileOptionsList.getOptionList(context);
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context,index){
                return Center(
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: const Color(MyColor.colorWhite),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      onTap: (){
                        Navigator.pop(context,index);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(MyColor.colorGrey0)
                              ),
                                child: Padding(
                                  padding: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
                                  child: Icon(Icons.lock_outline_rounded,color: const Color(MyColor.colorBlack),size: ScreenSize(context).heightOnly(1.8),),
                                )
                            ),
                            const DividerByWidth(3),
                            Text(
                              list[index].title,
                              style: GetFont.get(
                                  context,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 1.8,
                                  color: MyColor.colorBlack
                              ),
                            ),
                            const DividerByWidth(4),
                            Icon(Icons.arrow_forward_ios_outlined,color: const Color(MyColor.colorPrimary),size: ScreenSize(context).heightOnly(2.2),),
                            const DividerByWidth(1),
                          ],
                        )
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context,index){
                return const DividerByHeight(3.0);
              },
              itemCount: list.length
          ),
        ),
      ),
    );
  }
}
