import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestLeaveEncashmentListeners/request_encashment_form_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/hide_keyboard.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';

class SpecialRequestDropDownField extends StatefulWidget {
  RequestEnCashmentData? requestEnCashmentData;
  SpecialRequestDropDownField(this.requestEnCashmentData,{Key? key}) : super(key: key);

  @override
  State<SpecialRequestDropDownField> createState() => _SpecialRequestDropDownFieldState();
}

class _SpecialRequestDropDownFieldState extends State<SpecialRequestDropDownField> {
  String? selectedString;
  TextEditingController spinnerController = TextEditingController();
  List<String>? list;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    spinnerController.dispose();
    list = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(list == null)
    {
      if(widget.requestEnCashmentData?.index == 0)
      {
        list = List.empty(growable: true);
        list?.add(CallLanguageKeyWords.get(context, LanguageCodes.option)!);
        for(int x=0;x<widget.requestEnCashmentData!.data!.length;x++)
        {
          list?.add(widget.requestEnCashmentData!.data[x].typeTitle!);
        }
      }
      if(widget.requestEnCashmentData?.index == 4)
      {
        list = List.empty(growable: true);
        list?.add(CallLanguageKeyWords.get(context, LanguageCodes.option)!);
        for(int x=0;x<widget.requestEnCashmentData!.data!.length;x++)
        {
          list?.add(widget.requestEnCashmentData!.data[x]!);
        }
      }
      if(widget.requestEnCashmentData?.index == 6)
      {
        list = List.empty(growable: true);
        list?.add(CallLanguageKeyWords.get(context, LanguageCodes.option)!);
        for(int x=0;x<widget.requestEnCashmentData!.data!.length;x++)
        {
          list?.add(widget.requestEnCashmentData!.data[x].typeName!);
        }
      }
      selectedString = list![0];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
            child:
            Row(
              children: [
              Text(
                widget.requestEnCashmentData?.title??'',
                style: GetFont.get(
                    context,
                    fontSize: 1.6,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                ),
              ),
              //Expanded(child: Container(),),
              if(widget.requestEnCashmentData?.isRequired==true)...
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
            )
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
          child: DropdownSearch<String>(
            //mode: Mode.BOTTOM_SHEET,
              popupProps: PopupProps.modalBottomSheet(
                showSearchBox: true,
                constraints: BoxConstraints(maxHeight: ScreenSize(context).heightOnly( 80),),
                // scrollbarProps: ScrollbarProps(
                //
                // ),
                modalBottomSheetProps: const ModalBottomSheetProps(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    useSafeArea: false
                  //    elevation: 10
                ),
                disabledItemFn: (String s) => s=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}',
                itemBuilder: dropDownTextList,
                searchFieldProps:  TextFieldProps(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.2),vertical: ScreenSize(context).heightOnly( 2.4)),
                  controller: spinnerController,
                  decoration: InputDecoration(
                    hintText: 'Search something',
                    fillColor: Color(widget.requestEnCashmentData?.isEnable==false?MyColor.colorGrey7:MyColor.colorTransparent),
                    hintStyle: GetFont.get(
                        context,
                        color: MyColor.colorGrey3,
                        fontSize: 1.6,
                        fontWeight: FontWeight.w400
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),

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
                  fillColor: Color(widget.requestEnCashmentData?.isEnable==false?MyColor.colorGrey7:MyColor.colorTransparent),
                  enabled: widget.requestEnCashmentData?.isEnable??true,
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
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(MyColor.colorPrimary),
                      )
                  ),
                ),
              ),

              enabled: widget.requestEnCashmentData?.isEnable??true,
              //maxHeight: ScreenSize(context).heightOnly( 80),
              dropdownBuilder: spinnerText,
              // popupShape: const RoundedRectangleBorder(
              //   borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(30),
              //     topRight: Radius.circular(30),
              //   ),
              // ),
              onSaved: (text){
                HideShowKeyboard.hide(context);
              },
              //popupItemBuilder: dropDownTextList,
              // searchFieldProps:
              // popupTitle: const Text(
              //   '',
              // ),
              //  dropdownBuilderSupportsNullItem: true,
              items: list!,

              onChanged: (dat)
              {
                //print('kasdjaskndj ${widget.requestEnCashmentData?.index}');
                HideShowKeyboard.hide(context);
                if(widget.requestEnCashmentData?.data!=null&&widget.requestEnCashmentData?.index==0&&widget.requestEnCashmentData!.data!.isNotEmpty) {
                  int index = widget.requestEnCashmentData!.data!.indexWhere((element) => element.typeTitle == dat);
                  if(index!=-1)
                  {
                    widget.requestEnCashmentData!.callBack!(RequestEnCashmentCallBack(index: widget.requestEnCashmentData?.index,data: widget.requestEnCashmentData?.data[index]));
                  }
                }
                if(widget.requestEnCashmentData?.data!=null&&widget.requestEnCashmentData?.index==4&&widget.requestEnCashmentData!.data!.isNotEmpty)
                {
                  int index = widget.requestEnCashmentData!.data!.indexWhere((element) => element == dat);
                  if(index!=-1)
                  {
                    widget.requestEnCashmentData!.callBack!(RequestEnCashmentCallBack(index: widget.requestEnCashmentData?.index,data: index));
                  }
                }
                if(widget.requestEnCashmentData?.data!=null&&widget.requestEnCashmentData?.index==6&&widget.requestEnCashmentData!.data!.isNotEmpty)
                {
                  int index = widget.requestEnCashmentData!.data!.indexWhere((element) => element.typeName == dat);

                  print('jknsfkjsd $index');
                  if(index!=-1)
                  {
                    widget.requestEnCashmentData!.callBack!(RequestEnCashmentCallBack(index: widget.requestEnCashmentData?.index,data: widget.requestEnCashmentData?.data[index]));
                  }

                }
              },
              selectedItem: selectedString
          ),
        )
      ],
    );
  }
  // class RequestCallBack
  // {
  // dynamic response;
  // int? index;
  // UiTypes? uiTypes;
  // RequestCallBack(this.response,this.index,this.uiTypes);
  // }
  Widget dropDownTextList(BuildContext context, String? item,bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6),vertical:ScreenSize(context).heightOnly( 1.6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
              item??'',
              style: GetFont.get(
                  context,
                  fontWeight: item=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}'?FontWeight.w400:FontWeight.w500,
                  fontSize: 1.8,
                  color: item=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}'?MyColor.colorGrey3:MyColor.colorBlack
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
          item??'',
          style: GetFont.get(
              context,
              fontWeight: item=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}'?FontWeight.w400:FontWeight.w600,
              fontSize: 1.6,
              color: item=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}'?MyColor.colorGrey3:MyColor.colorBlack
          )
      ),
    );
  }
}