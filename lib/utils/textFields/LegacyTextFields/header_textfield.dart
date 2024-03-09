import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/TextFields/LegacyTextFields/text_widgets.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class HeaderTextField extends StatelessWidget {
  final TextEditingController? textController;
  final FocusScopeNode nodeFocus;
  final String? headerText,hintText;
  final bool? isCompulsory;
  final Function(String)? callBack;
  const HeaderTextField(this.headerText,this.hintText,this.textController,this.nodeFocus,this.isCompulsory,{this.callBack,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
          child: Row(
            children: [
              Text(
                headerText??'',
                style: GetFont.get(
                    context,
                    fontSize: 1.6,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                ),
              ),
              if(isCompulsory!=null&&isCompulsory == true)...[
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
        TextWidget(textController!,TextInputAction.done,nodeFocus, Key('Key$headerText'),hintText,padding: 4,stroke: 0.8,height: 6.2,callBack: callBack,),
      ],
    );
  }
}
