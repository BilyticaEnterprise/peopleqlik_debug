import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/SubModules/DocumentModule/presentation/ui/widget/document_list_widget.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/Default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class DocumentMainPage extends StatelessWidget {
  const DocumentMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetPageStarterScaffoldStateLess(
      title: CallLanguageKeyWords.get(context, LanguageCodes.documentsPage),
      body: _BodyData(),
    );
  }
}
class _BodyData extends StatefulWidget {
  const _BodyData({super.key});

  @override
  State<_BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<_BodyData> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(6), ScreenSize(context).heightOnly(2), ScreenSize(context).widthOnly(6), ScreenSize(context).heightOnly(6)),
        itemBuilder: (context,index){
        return DocumentListWidget(onTap: () {  },);
        },
        separatorBuilder: (context,index){
        return const DividerByHeight(3);
        },
        itemCount: 3
    );
  }
}
