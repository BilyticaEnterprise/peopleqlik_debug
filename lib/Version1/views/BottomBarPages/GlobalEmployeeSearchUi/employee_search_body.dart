import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/hide_keyboard.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

import '../../../../Version1/viewModel/EmployeeSearchController/employee_search_bottom_sheet_listener.dart';
import '../../../../utils/Reuse_LogicalWidgets/tick_icon.dart';
import 'employee_search_textfield.dart';

class EmployeeSearchBody extends StatelessWidget {
  const EmployeeSearchBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          HideShowKeyboard.hide(context);
        },
        child: const SearchEmployeeListWidget()
    );
  }
}
class SearchEmployeeListWidget extends StatefulWidget {
  const SearchEmployeeListWidget({Key? key}) : super(key: key);

  @override
  State<SearchEmployeeListWidget> createState() => _SearchEmployeeListWidgetState();
}

class _SearchEmployeeListWidgetState extends State<SearchEmployeeListWidget> {
  late FocusScopeNode focusScopeNode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchAnythingTextField(SearchData(data: null,isEnable: true,callBack: callback),focusScopeNode,key: const Key('SearchText'),),
          Flexible(
            child: Consumer<EmployeeSearchBottomSheetListener>(
                builder: (context, data, child) {
                  if(data.apiStatus == ApiStatus.done)
                  {
                    return ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6),ScreenSize(context).heightOnly( 3),ScreenSize(context).widthOnly( 5.6),ScreenSize(context).heightOnly( 10)),
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
                                  onTap: (){
                                    HideShowKeyboard.hide(context);
                                    data.updateSelectedIndex(index);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 2)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data.teamDataList?[index].fullName??'',
                                            style: GetFont.get(
                                                context,
                                                fontSize:1.6,
                                                fontWeight: FontWeight.w400,
                                                color: MyColor.colorBlack
                                            ),
                                          ),
                                        ),
                                        TickIcon(check: data.selectedIndex==index?true:false,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context,index){
                          return SizedBox(height: ScreenSize(context).heightOnly( 2),);
                        },
                        itemCount: data.teamDataList?.length??0

                    );
                  }
                  else if(data.apiStatus == ApiStatus.empty)
                  {
                    return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr54)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr55)}',topMargin: 8,width: 40,);
                  }
                  else if(data.apiStatus == ApiStatus.error)
                  {
                    return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
                  }
                  else if(data.apiStatus == ApiStatus.nothing)
                  {
                    return NotAvailable('search', '${CallLanguageKeyWords.get(context, LanguageCodes.searchEmployeeHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.searchEmployeeValue)}',topMargin: 8,width: 30);
                  }
                  else
                  {
                    return const CircularIndicatorCustomized(marginTop: 10,);
                  }
                }
            ),
          ),
          SizedBox(height: ScreenSize(context).heightOnly( 6),),
        ],
      ),
    );
  }
  callback(String data)
  {
    Provider.of<EmployeeSearchBottomSheetListener>(context,listen: false).searchEmployee(context,data);
  }
}
