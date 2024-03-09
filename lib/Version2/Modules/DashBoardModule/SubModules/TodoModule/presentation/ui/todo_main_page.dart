import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/SubModules/TodoModule/presentation/ui/widget/tab_bar_todo.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/Default_Screens/scafold_screens/default_screens.dart';

import '../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../utils/screen_sizes.dart';
import '../../../../presentation/ui/DashBoardSubWidgets/widgets/todos_widgets/widget/todo_display_widget.dart';

class TodoMainPage extends StatelessWidget {
  const TodoMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetPageStarterScaffoldStateLess(
        title: CallLanguageKeyWords.get(context, LanguageCodes.todos),
        body: _BodyData()
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
    return Column(
      children: [
        TabBarTodo(),
        DividerByHeight(2),
        ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(6), ScreenSize(context).heightOnly(2), ScreenSize(context).widthOnly(6), ScreenSize(context).heightOnly(6)),
            itemBuilder: (context,index){
              return TodoDisplayWidget(red: index==0?true:false,);
            },
            separatorBuilder: (context,index){
              return const DividerByHeight(3);
            },
            itemCount: 3
        )
      ],
    );
  }
}
