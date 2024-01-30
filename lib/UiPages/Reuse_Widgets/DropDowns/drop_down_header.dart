import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:provider/provider.dart';
import '../../../BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import '../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../src/colors.dart';
import '../../../src/fonts.dart';
import '../../../src/language_codes.dart';
import '../../../src/screen_sizes.dart';
import 'package:dropdown_search/dropdown_search.dart';

class HeaderDropDownField extends StatelessWidget {
  final DropDownDataController dropDownDataType;
  final String header;
  final double? height;
  final int? selectedIndex;
  final LanguageEnum? languageEnum;
  final bool? isCompulsory;
  final bool? clearAll;
  final double? margin;
  final bool? isEnabled;
  final Function(SelectedDropDown) onSelectedDropDown;
  const HeaderDropDownField({required this.dropDownDataType,required this.header,this.height,this.margin,this.isEnabled,required this.onSelectedDropDown,this.isCompulsory = false,this.languageEnum,this.selectedIndex,this.clearAll,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _HeaderDropDownFieldIs(dropDownDataType: dropDownDataType,header: header,height: height,margin: margin,isEnabled: isEnabled,onSelectedDropDown: onSelectedDropDown,isCompulsory: isCompulsory,languageEnum: languageEnum,selectedIndex: selectedIndex,clearAll: clearAll);
  }
}


class _HeaderDropDownFieldIs extends StatefulWidget {
  final DropDownDataController dropDownDataType;
  final String header;
  final double? height;
  final int? selectedIndex;
  final LanguageEnum? languageEnum;
  final bool? isCompulsory;
  final bool? clearAll;
  final double? margin;
  final bool? isEnabled;
  final Function(SelectedDropDown) onSelectedDropDown;
  const _HeaderDropDownFieldIs({required this.dropDownDataType,required this.header,this.height,this.margin,this.isEnabled,required this.onSelectedDropDown,this.isCompulsory = false,this.languageEnum,this.selectedIndex,this.clearAll,Key? key}) : super(key: key);

  @override
  State<_HeaderDropDownFieldIs> createState() => _HeaderDropDownFieldIsState();
}

class _HeaderDropDownFieldIsState extends State<_HeaderDropDownFieldIs> {
  String? selectedString;
  late String optionalString;
  TextEditingController spinnerController = TextEditingController();
  List<String>? list;
  @override
  void initState() {

    optionalString = CallLanguageKeyWords.get(GetNavigatorStateContext.navigatorKey.currentState!.context, LanguageCodes.option)??'';
    if(widget.dropDownDataType.list!=null)
      {
        list = List.generate(widget.dropDownDataType.list.length, (index) => widget.dropDownDataType.list[index]);
        list?.insert(0, optionalString);
      }
    else
      {
        list ??= List.empty(growable: true);  /// if somehow data was empty then initialize this list
        list?.add(optionalString);
      }
    if(widget.selectedIndex!=null)
    {
      selectedString = list![(widget.selectedIndex!)+1];
    }
    else
    {
      selectedString = list![0];
    }
    super.initState();
  }

  @override
  void dispose() {
    spinnerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.clearAll!=null&&widget.clearAll==true)
    {
      try{spinnerController.clear();}catch(e){}
      list = widget.dropDownDataType.list.cast<String>();
      selectedString = list![0];
      //PrintLogs.print('ayaaafilll');
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(widget.margin??6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                widget.header??'',
                style: GetFont.get(
                    context,
                    fontSize: 1.6,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                ),
              ),
              //Expanded(child: Container(),),
              if(widget.isCompulsory==true)...
              [
                SizedBox(width: ScreenSize(context).heightOnly( 1),),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Material(
                    color: const Color(MyColor.colorSecondary).withOpacity(0.8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1),vertical: ScreenSize(context).heightOnly( 0.3)),
                      child: Text(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra2)}',
                        style: GetFont.get(
                            context,
                            fontSize: 1.0,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorWhite
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ],
          ),
          SizedBox(height: ScreenSize(context).heightOnly(1.2),),
          DropdownSearch<String>(
            enabled: widget.isEnabled??true,
                popupProps: PopupProps.modalBottomSheet(
                  showSearchBox: true,
                  constraints: BoxConstraints(maxHeight: ScreenSize(context).heightOnly(90),),
                  modalBottomSheetProps: const ModalBottomSheetProps(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      useSafeArea: false
                  ),
                  disabledItemFn: (String s) => s==optionalString,
                  itemBuilder: dropDownTextList,
                  searchFieldProps: TextFieldProps(
                    padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(7),ScreenSize(context).heightOnly(4),ScreenSize(context).widthOnly(7),ScreenSize(context).heightOnly(2)),
                    controller: spinnerController,
                    decoration: InputDecoration(
                      hintText: '${CallLanguageKeyWords.get(context, LanguageCodes.searchEmployeeHeader)}',
                      constraints: BoxConstraints(maxHeight: ScreenSize(context).heightOnly(widget.height??7),minHeight: ScreenSize(context).heightOnly(widget.height??7)),
                      contentPadding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(4),vertical: 0),
                      hintStyle: GetFont.get(
                          context,
                          color: MyColor.colorGrey3,
                          fontSize: 1.6,
                          fontWeight: FontWeight.w400
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        iconSize: ScreenSize(context).heightOnly(3),
                        onPressed: () {
                          spinnerController.clear();
                        },
                      ),
                    ),
                  ),
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 2.5), ScreenSize(context).heightOnly( 0.4), ScreenSize(context).widthOnly( 1), 0),
                    fillColor: Color(widget.isEnabled==false?MyColor.colorGrey7:MyColor.colorTransparent),
                    enabled: widget.isEnabled??true,
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          width: 0.8,
                          color: Color(MyColor.colorBlack),
                        )
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          width: 1.4,
                          color: Color(MyColor.colorBlack),
                        )
                    ),
                    disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          width: 0.8,
                          color: Color(MyColor.colorGrey7),
                        )
                    ),
                  ),
                ),
                dropdownBuilder: spinnerText,
                items: list!,
                onChanged: (dat)
                {
                  int? index = widget.dropDownDataType.list.indexWhere((element) => element == dat);
                  if(index!=null&&index!=-1)
                  {
                    widget.onSelectedDropDown(SelectedDropDown(widget.dropDownDataType.dropDownTypeEnum,dat,(index)));
                  }
                },
                selectedItem: selectedString
          ),
        ],
      ),
    );
  }

  Widget dropDownTextList(BuildContext context, String? item,bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(7),vertical:ScreenSize(context).heightOnly(1.6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
                item??'',
                style: GetFont.get(
                    context,
                    fontWeight: item=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}'?FontWeight.w400:FontWeight.w500,
                    fontSize: 1.8,
                    color: item=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}'?MyColor.colorGrey3:MyColor.colorBlack
                )
            )
          )
        ],
      ),
    );
  }

  Widget spinnerText(BuildContext context, String? item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(2),vertical: ScreenSize(context).heightOnly(1.2)),
      child: Text(
          item??'',
          style: GetFont.get(
              context,
              fontWeight: item=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}'?FontWeight.w400:FontWeight.w600,
              fontSize: 1.6,
              color: item=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}'||widget.isEnabled==false?MyColor.colorGrey3:MyColor.colorBlack
          )
      ),
    );
  }
}
class DropDownDataController<T>
{
  dynamic dropDownTypeEnum;
  List<T> list;
  DropDownDataController(this.dropDownTypeEnum,this.list);

  dispose()
  {
    dropDownTypeEnum = null;
  }
}
class SelectedDropDown
{
  dynamic dropDownTypeEnum;
  String? selectedValue;
  int? index;
  SelectedDropDown(this.dropDownTypeEnum,this.selectedValue,this.index);
}
// class DropDownList<T>
// {
//   DropDownDataController dropDownDataController;
//   int? selectedIndex;
//   bool? forTheFirstTime;
//
//   DropDownList({required this.dropDownDataController,this.selectedIndex,this.forTheFirstTime});
//   dispose()
//   {
//     dropDownDataController.dispose();
//     selectedIndex = null;
//     forTheFirstTime = null;
//   }
// }