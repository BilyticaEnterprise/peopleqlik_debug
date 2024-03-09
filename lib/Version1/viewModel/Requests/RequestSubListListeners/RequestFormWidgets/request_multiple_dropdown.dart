import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/Models/PaysSlipApprovalsRequest/request_list_form_model.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/Buttons/buttons.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/hide_keyboard.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../request_form_get_listener.dart';

class MultiDropDownField extends StatefulWidget {
  final RequestSender? requestSender;
  final Function(RequestCallBack)? callBack;
  const MultiDropDownField(this.requestSender,this.callBack,{Key? key}) : super(key: key);

  @override
  State<MultiDropDownField> createState() => _MultiDropDownFieldState();
}

class _MultiDropDownFieldState extends State<MultiDropDownField> {
  List<String>? selectedString;
  TextEditingController spinnerController = TextEditingController();
  List<String>? list;
  GlobalKey globalKey = GlobalKey();
  @override
  void initState() {
    init();
    super.initState();
  }
  init()
  {
    list = List.empty(growable: true);
    selectedString = List.empty(growable: true);
    if(widget.requestSender?.data!=null&&widget.requestSender!.data!.isNotEmpty)
    {
      for(int x=0;x<widget.requestSender!.data!.length;x++)
      {
        list?.add(widget.requestSender!.data![x].name);
      }
      if(widget.requestSender?.selectedIndex!=null&&widget.requestSender?.selectedIndex!=-1)
      {
        // PrintLogs.print('or bhai ${widget.requestSender!.selectedIndex!}');
         selectedString?.add(list![widget.requestSender!.selectedIndex!]);
      }
      else
      {
        selectedString?.add(list![0]);
      }
    }
  }
  @override
  void dispose() {
    spinnerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(Provider.of<GetRequestFormListener>(context,listen: false).formList[widget.requestSender!.dataIndex!].doUpdate==true)
    {
      Provider.of<GetRequestFormListener>(context,listen: false).formList[widget.requestSender!.dataIndex!].doUpdate = false;
      init();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
            child: Row(
              children: [
                Text(
                  '${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra3)} ${widget.requestSender?.header}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w600,
                      color: MyColor.colorBlack
                  ),
                ),
                //Expanded(child: Container(),),
                if(widget.requestSender?.dependent?.isDependent==true)...[
                  SizedBox(width: ScreenSize(context).heightOnly( 1),),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Material(
                      color: const Color(MyColor.colorPrimary).withOpacity(0.8),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1),vertical: ScreenSize(context).heightOnly( 0.3)),
                        child: Text(
                          '${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra1)} ${widget.requestSender?.dependent?.name}',
                          style: GetFont.get(
                              context,
                              fontSize: 1.0,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorWhite
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                if(widget.requestSender?.admRequestManagerDt?.isRequired==true)...
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
          child: DropdownSearch<String>.multiSelection(
              key: globalKey,
              popupProps: PopupPropsMultiSelection.bottomSheet(
                constraints: BoxConstraints(maxHeight: ScreenSize(context).heightOnly( 80),),
                showSearchBox: true,
                itemBuilder: dropDownTextList,
                bottomSheetProps: const BottomSheetProps(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                selectionWidget: popupSelectionWidget,
                disabledItemFn: (String s) => s=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}',
                searchFieldProps: TextFieldProps(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.2),vertical: ScreenSize(context).heightOnly( 2)),
                  controller: spinnerController,
                  decoration: InputDecoration(
                    hintText: 'Search something',
                    fillColor: Color(widget.requestSender?.isEnable==false?MyColor.colorBackgroundDark:MyColor.colorTransparent),
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
                  fillColor: Color(widget.requestSender?.isEnable==false?MyColor.colorBackgroundDark:MyColor.colorTransparent),
                  enabled: widget.requestSender?.isEnable??true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                        width: 0.8,
                        color: Color(widget.requestSender?.dependent?.isDependent==true?MyColor.colorT6:MyColor.colorBlack),
                      )
                  ),
                  disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                        width: 0.8,
                        color: Color(MyColor.colorBackgroundDark),
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

              enabled: widget.requestSender?.isEnable??true,
             // maxHeight: ScreenSize(context).heightOnly( 80),
              dropdownBuilder: spinnerText,

              onSaved: (text){
                HideShowKeyboard.hide(context);
              },
              //popupItemBuilder: dropDownTextList,
              // searchFieldProps:
              // popupTitle: const Text(
              //   '',
              // ),
              //popupSelectionWidget: popupSelectionWidget,
              //dropdownBuilderSupportsNullItem: true,
              items: list!,
              onChanged: (dat)
              {
                HideShowKeyboard.hide(context);
                if(widget.requestSender?.data!=null&&widget.requestSender!.data!.isNotEmpty) {
                  int index = widget.requestSender!.data!.indexWhere((element) => element.name == dat);
                  if(index!=-1)
                  {
                    widget.callBack!(RequestCallBack(widget.requestSender!.data![index],widget.requestSender!.uiIndex,widget.requestSender!.dataIndex,widget.requestSender?.uiTypes,widget.requestSender?.dependent,widget.requestSender?.isEnable,widget.requestSender?.admRequestManagerDt,selectedIndex: index));
                  }
                }
              },
              selectedItems: selectedString!
          ),
        )
      ],
    );
  }
  onPressed()
  {}
  // class RequestCallBack
  // {
  // dynamic response;
  // int? index;
  // UiTypes? uiTypes;
  // RequestCallBack(this.response,this.index,this.uiTypes);
  // }
  Widget dropDownTextList(BuildContext context, String? item,bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6),vertical:ScreenSize(context).heightOnly( 2.2)),
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

  Widget spinnerText(BuildContext context, List<String> item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 2),),
      child: SizedBox(
        height: ScreenSize(context).heightOnly( 6.5),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 1.5),bottom: ScreenSize(context).heightOnly( 1.5)),
          itemBuilder: (context,index){
            if(item.length>1&&index == 0)
              {
                return const SizedBox(height: 0,width: 0,);
              }
              else {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Material(
                  color: const Color(MyColor.colorBackgroundDark),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1.5),vertical: ScreenSize(context).heightOnly( 0.8)),
                    child: Text(
                      item[index],
                      style: GetFont.get(
                          context,
                          fontWeight: item[index]=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}'?FontWeight.w400:FontWeight.w400,
                          fontSize: 1.4,
                          color: item[index]=='${CallLanguageKeyWords.get(context, LanguageCodes.option)}'?MyColor.colorGrey3:MyColor.colorBlack
                      )
            ),
                  ),
                ),
              );
            }
          },
          separatorBuilder: (context,index){
            return SizedBox(width: ScreenSize(context).heightOnly( 1),);
          },
          itemCount: item.length,
        ),
      )
    );
  }

  Widget popupSelectionWidget(BuildContext context, String item, bool isSelected) {
    return Container(
      width: ScreenSize(context).heightOnly( 3.2),
      height: ScreenSize(context).heightOnly( 3.2),
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected==true?Color(item == '${CallLanguageKeyWords.get(context, LanguageCodes.option)}'?MyColor.colorGrey0:MyColor.colorPrimary):null,
        border: isSelected==true?null:Border.all(
          color: const Color(MyColor.colorBlack),
          width: 0.7
        )
      ),
    );
  }
}