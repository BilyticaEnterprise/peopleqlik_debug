import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/presentation/bloc/doument_filter_implementation_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/presentation/ui/widget/document_filter_list_widget.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_single_button.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class DocumentFilterWidget extends StatelessWidget {
  final int defaultSelectedTypeId;
  const DocumentFilterWidget({required this.defaultSelectedTypeId,super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<DocumentFilterImplementationBloc>(create: (_) => DocumentFilterImplementationBloc(AppStateNothing(), defaultSelectedTypeId: defaultSelectedTypeId,))
      ],
      builder: (context) {
        return const _BodyData();
      }
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<DocumentFilterImplementationBloc>(context,listen: false).createListWithDefaultSelectedTypeId(context: context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DocumentFilterImplementationBloc bloc = BlocProvider.of<DocumentFilterImplementationBloc>(context,listen: false);
    return BlocConsumer<DocumentFilterImplementationBloc,AppState>(
      listener: (context,data){},
      builder: (context, data) {
        if(data is AppStateDone)
          {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                      padding: EdgeInsets.only(top: ScreenSize(context).heightOnly(2)),
                      itemBuilder: (context,index){
                      return DocumentFilterListWidget(
                        name: bloc.getList()?[index].typeName??'',
                        onTap: () {
                          bloc.updateSelectedIndex(index);
                        },
                        isSelected: index == data.data,);
                      },
                      separatorBuilder: (context,index){
                      return const DividerByHeight(2);
                      },
                      itemCount: bloc.getList()?.length??0),
                ),
                BottomSingleButton(
                  text: '${CallLanguageKeyWords.get(context, LanguageCodes.done)}',
                  buttonColor: MyColor.colorPrimary,
                  textColor: MyColor.colorWhite,
                  onPressed: (){
                    Navigator.pop(context,bloc.getSelectedTypeId());
                  },
                )
              ],
            );
          }
        else
          {
            return const CircularIndicatorCustomized();
          }
      }
    );
  }
}
