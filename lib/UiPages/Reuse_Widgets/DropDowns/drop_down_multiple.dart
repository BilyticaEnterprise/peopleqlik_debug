import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:provider/provider.dart';
import '../../../BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import '../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../src/colors.dart';
import '../../../src/fonts.dart';
import '../../../src/language_codes.dart';
import '../../../src/map_indexed.dart';
import '../../../src/screen_sizes.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/OvertimeFormPages/UiWidgets/FiltreUi/UiWidgets/select_employee.dart';
import '../../Reuse_LogicalWidgets/custom_chips.dart';
import '../Buttons/bottom_single_button.dart';
import '../Buttons/buttons.dart';

class MultiHeaderDropDownField extends StatelessWidget {
  final MultiDropDownDataController dropDownDataType;
  final String header;
  final double? height;
  final List<String>? selectedIndexes;
  final LanguageEnum? languageEnum;
  final bool? isCompulsory;
  final bool? clearAll;
  final double? margin;
  final bool? isEnabled;
  final Function(MultiSelectedDropDown) onSelectedDropDown;
  const MultiHeaderDropDownField({required this.dropDownDataType,required this.header,this.height,this.margin,this.isEnabled,required this.onSelectedDropDown,this.isCompulsory = false,this.languageEnum,this.selectedIndexes,this.clearAll,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MultiDropDownController>(
      create: (_) => MultiDropDownController(),
      builder: (context, snapshot) {
        return _MultiHeaderDropDownFieldIs(dropDownDataType: dropDownDataType,header: header,height: height,margin: margin,isEnabled: isEnabled,onSelectedDropDown: onSelectedDropDown,isCompulsory: isCompulsory,languageEnum: languageEnum,selectedIndexes: selectedIndexes,clearAll: clearAll);
      }
    );
  }
}


class _MultiHeaderDropDownFieldIs extends StatefulWidget {
  final MultiDropDownDataController dropDownDataType;
  final String header;
  final double? height;
  final List<String>? selectedIndexes;
  final LanguageEnum? languageEnum;
  final bool? isCompulsory;
  final bool? clearAll;
  final double? margin;
  final bool? isEnabled;
  final Function(MultiSelectedDropDown) onSelectedDropDown;
  const _MultiHeaderDropDownFieldIs({required this.dropDownDataType,required this.header,this.height,this.margin,this.isEnabled,required this.onSelectedDropDown,this.isCompulsory = false,this.languageEnum,this.selectedIndexes,this.clearAll,Key? key}) : super(key: key);

  @override
  State<_MultiHeaderDropDownFieldIs> createState() => _MultiHeaderDropDownFieldIsState();
}

class _MultiHeaderDropDownFieldIsState extends State<_MultiHeaderDropDownFieldIs> {
  late List<String> selectedStringList;
  late String optionalString;
  final GlobalKey<DropdownSearchState> _popupCustomValidationKey = GlobalKey<DropdownSearchState>();
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
    if(widget.selectedIndexes!=null)
    {
      selectedStringList = widget.selectedIndexes!;
    }
    else
    {
      selectedStringList = [optionalString];
    }
    Provider.of<MultiDropDownController>(context,listen: false).initialSelectedList(selectedStringList,optionalString);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 50),(){Provider.of<MultiDropDownController>(context,listen: false).getInitialHeight(_popupCustomValidationKey);});
    });
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
      selectedStringList = [optionalString];
      //PrintLogs.print('ayaaafilll');
    }
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
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
          Consumer<MultiDropDownController>(
            builder: (context, data, child) {
              return DropdownSearch<String>.multiSelection(
                  key: _popupCustomValidationKey,
                  enabled: widget.isEnabled??true,
                  popupProps: PopupPropsMultiSelection.modalBottomSheet(
                    showSearchBox: true,
                    validationWidgetBuilder: BottomDoneButton,
                    constraints: BoxConstraints(maxHeight: ScreenSize(context).heightOnly(90),),
                    modalBottomSheetProps: const ModalBottomSheetProps(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        useSafeArea: false,
                    ),
                    disabledItemFn: (String s) => s==optionalString,
                    selectionWidget: selectionWidget,
                    errorBuilder: errorBuilder,
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
                      contentPadding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(changeLanguage.languageEnum==LanguageEnum.english?(data.listLengthGreaterThanZero==true?0.6:2.5):1.0), ScreenSize(context).heightOnly(0.4), ScreenSize(context).widthOnly(changeLanguage.languageEnum==LanguageEnum.english?1:(data.listLengthGreaterThanZero==true?0.6:2.5)), 0),
                      fillColor: Color(widget.isEnabled==false?MyColor.colorGrey7:MyColor.colorTransparent),
                      enabled: widget.isEnabled??true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular((data.currentHeight??0)>(data.previousHeight??0)?24:50)),
                          borderSide: const BorderSide(
                            width: 0.8,
                            color: Color(MyColor.colorBlack),
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular((data.currentHeight??0)>(data.previousHeight??0)?24:50)),
                          borderSide: const BorderSide(
                          width: 1.4,
                            color: Color(MyColor.colorBlack),
                          )
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular((data.currentHeight??0)>(data.previousHeight??0)?24:50)),
                          borderSide: const BorderSide(
                          width: 0.8,
                            color: Color(MyColor.colorGrey7),
                          )
                      ),
                    ),
                  ),
                  dropdownBuilder: spinnerText,
                  items: list!,
                  onChanged: (dataList){
                  },
                  selectedItems: data.selectedString
              );
            }
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


  Widget spinnerText(BuildContext context, List<String> selectedItems) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(0.4),vertical: ScreenSize(context).heightOnly(0.4)),
      child: Wrap(
          children: mapIndexed(
              selectedItems,
                  (index, data) => data == optionalString?Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(2)),
                    child: Text(
                        optionalString??'',
                        style: GetFont.get(
                            context,
                            fontWeight: FontWeight.w400,
                            fontSize: 1.6,
                            color:MyColor.colorGrey3
                        )),
                  ):TextEmployeeChipWidget(
                      data,
              )
          ).toList()
      ),
    );
  }

  Widget selectionWidget(BuildContext context, String item, bool isSelected) {
    return
      item == optionalString?Container(height: 0,):
    Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(7),vertical:ScreenSize(context).heightOnly(1.6)),
      child: SizedBox(
          height: ScreenSize(context).heightOnly( 2.5),
          width: ScreenSize(context).heightOnly( 2.5),
          child: Icon(isSelected==true?MdiIcons.checkCircle:MdiIcons.circleOutline,color: Color(isSelected==true?MyColor.colorPrimary:MyColor.colorPrimary),size: ScreenSize(context).heightOnly(2.6),)
      ),
    );
  }

  Widget BottomDoneButton(BuildContext mContext, List<String> item) {
    return BottomSingleButton(text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsaddFormButton)}',onPressed: (){
      PrintLogs.printLogs('asdasdas ${item}');
      //SnackBarDesign.errorSnack(CallLanguageKeyWords.get(mContext, LanguageCodes.mustSelectOption));
      //throw UnsupportedError;
      if(item.isNotEmpty)
      {

        if(item.length>1)
          {
            int? index = item.indexWhere((element) => element == optionalString);
            if(index!=-1)
              {
                item.removeAt(index);
              }
            _popupCustomValidationKey.currentState?.changeSelectedItems(item);

            PrintLogs.printLogs('dataiss ${widget.dropDownDataType.list}');
            List<String> nowItems = _popupCustomValidationKey.currentState!.getSelectedItems as List<String>;
            PrintLogs.printLogs('nowItems ${nowItems}');

            List<int> indices = nowItems.map((value) => widget.dropDownDataType.list.indexOf(value)).toList();
            PrintLogs.printLogs('indices ${indices}');
            indices.removeWhere((element) => element ==-1);
            if(indices.isNotEmpty)
            {
              widget.onSelectedDropDown(MultiSelectedDropDown(widget.dropDownDataType.dropDownTypeEnum,nowItems,indices));
            }
            Provider.of<MultiDropDownController>(context,listen: false).refreshUi(true,_popupCustomValidationKey);
          }
        else
          {
            if(item.first == optionalString)
              {
                widget.onSelectedDropDown(MultiSelectedDropDown(widget.dropDownDataType.dropDownTypeEnum,null,null));
                SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.mustSelectOption));
                Provider.of<MultiDropDownController>(context,listen: false).refreshUi(false,_popupCustomValidationKey);
              }
            else
              {
                List<String> nowItems = _popupCustomValidationKey.currentState!.getSelectedItems as List<String>;
                List<int> indices = widget.dropDownDataType.list.map((value) => nowItems.indexOf(value)).toList();
                indices.removeWhere((element) => element ==-1);
                if(indices.isNotEmpty)
                {
                  widget.onSelectedDropDown(MultiSelectedDropDown(widget.dropDownDataType.dropDownTypeEnum,nowItems,indices));
                }
                Provider.of<MultiDropDownController>(context,listen: false).refreshUi(true,_popupCustomValidationKey);
              }
          }

        //Provider.of<MultiDropDownController>(context,listen: false).updateSelectedList(nowItems);
        _popupCustomValidationKey.currentState?.popupOnValidate();
      }
      else
        {
          item.add(optionalString);
          _popupCustomValidationKey.currentState?.changeSelectedItems(item);
          widget.onSelectedDropDown(MultiSelectedDropDown(widget.dropDownDataType.dropDownTypeEnum,null,null));
          SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.mustSelectOption));
          _popupCustomValidationKey.currentState?.popupOnValidate();
          Provider.of<MultiDropDownController>(context,listen: false).refreshUi(false,_popupCustomValidationKey);
        }
    },);
  }

  Widget errorBuilder(BuildContext context, String searchEntry, exception) {
    return Text('wjat ');
  }

}
class MultiDropDownDataController<T>
{
  dynamic dropDownTypeEnum;
  List<T> list;
  MultiDropDownDataController(this.dropDownTypeEnum,this.list);

  dispose()
  {
    dropDownTypeEnum = null;
  }
}
class MultiSelectedDropDown
{
  dynamic dropDownTypeEnum;
  List<String>? selectedValue;
  List<int>? index;
  MultiSelectedDropDown(this.dropDownTypeEnum,this.selectedValue,this.index);
}
class MultiDropDownController extends GetChangeNotifier
{
  late List<String> selectedString;
  late String optionalString;
  double? previousHeight;
  double? currentHeight;
  bool listLengthGreaterThanZero = false;

  void initialSelectedList(List<String> selectedString, String optionalString) {
    this.selectedString = selectedString;
    this.optionalString = optionalString;
  }

  void refreshUi(bool listLengthGreaterThanZero,GlobalKey<DropdownSearchState> popupCustomValidationKey)
  {
    this.listLengthGreaterThanZero = listLengthGreaterThanZero;
    Future.delayed(const Duration(milliseconds: 100),(){
      RenderBox box = popupCustomValidationKey.currentContext?.findRenderObject() as RenderBox;
      currentHeight = box.size.height;
      if((currentHeight??0)>(previousHeight??0))
      {
        notifyListeners();
        Future.delayed(const Duration(milliseconds: 100),(){
          previousHeight = currentHeight;
        });
      }
    });

  }

  void getInitialHeight(GlobalKey<DropdownSearchState> popupCustomValidationKey) {
    RenderBox box = popupCustomValidationKey.currentContext?.findRenderObject() as RenderBox;
    previousHeight = box.size.height;
    currentHeight = box.size.height;
    PrintLogs.printLogs('initialll $previousHeight $currentHeight');
  }

  // void updateSelectedList(List<String> selectedString) {
  //   selectedString.removeWhere((element) => element == optionalString);
  //   this.selectedString = selectedString;
  //   notifyListeners();
  // }
}