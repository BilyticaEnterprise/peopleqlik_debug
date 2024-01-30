import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:provider/provider.dart';

import '../../../BusinessLogicModel/Enums/employee_search_type.dart';
import '../../../BusinessLogicModel/Listeners/EmployeeSearchController/employee_search_bottom_sheet_listener.dart';
import '../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../src/colors.dart';
import '../../../src/fonts.dart';
import '../../../src/hide_keyboard.dart';
import '../../../src/language_codes.dart';
import '../../../src/screen_sizes.dart';

class HeaderEmployeeSearchBottomSheet extends StatelessWidget {
  final String? text;
  final Function()? onDoneTap;
  const HeaderEmployeeSearchBottomSheet({this.text,this.onDoneTap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize(context).widthOnly(100),
      height: ScreenSize(context).heightOnly(7),
      padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 2.8),0,ScreenSize(context).widthOnly( 4.6),0),
      decoration: const BoxDecoration(
        color: Color(MyColor.colorWhite),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ClipOval(
              child: Material(
                color: const Color(MyColor.colorTransparent),
                child: InkWell(
                    splashColor: const Color(MyColor.colorGrey0),
                    onTap: () async{
                      HideShowKeyboard.hide(context);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.6)),
                      child: Icon(
                        Icons.cancel_outlined,
                        size: ScreenSize(context).heightOnly( 3.2),
                        color: const Color(MyColor.colorBlack
                        ),
                      ),
                    )
                ),
              ),

            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Text(
                text??CallLanguageKeyWords.get(context, LanguageCodes.searchEmployeePanelHeader)??'',
                style: GetFont.get(
                    context,
                    fontSize:2.2,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Material(
                color: const Color(MyColor.colorPrimary),
                child: InkWell(
                  splashColor: const Color(MyColor.colorGrey0),
                  onTap: onDoneTap??() async {
                    HideShowKeyboard.hide(context);
                    EmployeeSearchBottomSheetListener employee = Provider.of<EmployeeSearchBottomSheetListener>(context,listen: false);
                    if(employee.selectedIndex!=null)
                    {
                      Navigator.pop(context,employee.getEmployee());
                    }
                    else
                    {
                      SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.searchMustSelect)}');
                    }

                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1.4),vertical: ScreenSize(context).heightOnly( 0.6)),
                    child: Text(
                      '${CallLanguageKeyWords.get(context, LanguageCodes.done)}',
                      style: GetFont.get(
                          context,
                          fontSize:1.3,
                          color: MyColor.colorWhite,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
