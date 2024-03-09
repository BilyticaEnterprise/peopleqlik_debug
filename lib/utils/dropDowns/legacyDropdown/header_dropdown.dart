import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class HeaderDropDownField extends StatefulWidget {
  final DropDownDataType? dropDownDataType;
  final String header;
  final bool? isCompulsory;
  final bool? clearAll;
  final Function(SelectedDropDown) onCountChanged;
  const HeaderDropDownField(this.dropDownDataType,this.header,this.onCountChanged,this.isCompulsory,{this.clearAll,Key? key}) : super(key: key);

  @override
  State<HeaderDropDownField> createState() => _HeaderDropDownFieldState();
}

class _HeaderDropDownFieldState extends State<HeaderDropDownField> {
  String? selectedString;
  String optionalString = 'Select an option';
  TextEditingController spinnerController = TextEditingController();
  List<String>? list;
  @override
  void initState() {
    list = widget.dropDownDataType?.list;
    selectedString = list![0];
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
        list = widget.dropDownDataType?.list;
        selectedString = list![0];
        //PrintLogs.print('ayaaafilll');
      }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
          child: Row(
            children: [
              Text(
                'Select ${widget.header}',
                style: GetFont.get(
                    context,
                    fontSize: 1.6,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                ),
              ),
              if(widget.isCompulsory!=null&&widget.isCompulsory == true)...[
                SizedBox(width: ScreenSize(context).heightOnly( 1),),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Material(
                    color: const Color(MyColor.colorSecondary).withOpacity(0.8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1),vertical: ScreenSize(context).heightOnly( 0.3)),
                      child: Text(
                        'Com',
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
          )
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
          child: DropdownSearch<String>(
              popupProps: PopupProps.modalBottomSheet(
                showSearchBox: true,
                constraints: BoxConstraints(maxHeight: ScreenSize(context).heightOnly( 80),),
                modalBottomSheetProps: const ModalBottomSheetProps(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  useSafeArea: false
                ),
                itemBuilder: dropDownTextList,
                disabledItemFn: (String s) => s==optionalString,
                searchFieldProps: TextFieldProps(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.2),vertical: ScreenSize(context).heightOnly( 2.4)),
                  controller: spinnerController,
                  decoration: InputDecoration(
                    hintText: 'Search something',
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
                      iconSize: ScreenSize(context).heightOnly( 3),
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
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                          width: 2,
                          color: Color(MyColor.colorBlack)
                      )
                  ),
                ),
              ),
              dropdownBuilder: spinnerText,
              // popupShape:
              // popupItemBuilder: dropDownTextList,

              items: list!,
              //popupItemDisabled: (String s) => s==optionalString,
              onChanged: (dat)
              {
                int? index = widget.dropDownDataType?.list.indexWhere((element) => element == dat);
                if(index!=null&&index!=-1)
                  {
                    widget.onCountChanged(SelectedDropDown(widget.dropDownDataType?.dropDownTypeEnum,dat,(index-1)));
                  }
              },
              selectedItem: selectedString),
        )
      ],
    );
  }

  Widget dropDownTextList(BuildContext context, String? item,bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6),vertical:ScreenSize(context).heightOnly( 1.6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
              item!,
              style: GetFont.get(
                  context,
                  fontWeight: item==optionalString?FontWeight.w400:FontWeight.w500,
                  fontSize: 1.8,
                  color: item==optionalString?MyColor.colorGrey3:MyColor.colorBlack
              )
          )
        ],
      ),
    );
  }

  Widget spinnerText(BuildContext context, String? item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 2),),
      child: Text(
          item!,
          style: GetFont.get(
              context,
              fontWeight: item==optionalString?FontWeight.w400:FontWeight.w600,
              fontSize: 1.6,
              color: item==optionalString?MyColor.colorGrey3:MyColor.colorBlack
          )
      ),
    );
  }
}
class DropDownDataType
{
  DropDownTypeEnum dropDownTypeEnum;
  List<String> list;
  DropDownDataType(this.dropDownTypeEnum,this.list);
}
class SelectedDropDown
{
  DropDownTypeEnum? dropDownTypeEnum;
  String? selectedValue;
  int? index;
  SelectedDropDown(this.dropDownTypeEnum,this.selectedValue,this.index);
}
enum DropDownTypeEnum
{
  leaveType,leaveReason,fullDay
}