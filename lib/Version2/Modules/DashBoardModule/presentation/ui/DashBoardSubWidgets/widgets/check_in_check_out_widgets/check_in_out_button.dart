import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class CheckInOutButton extends StatelessWidget {
  String? header,text,buttonText;
  int? buttonColor,iconColor;
  IconData? icon;
  bool enabled;
  void Function()? onPressed;
  CheckInOutButton( this.onPressed, {required this.enabled,this.header,this.text,this.buttonText,this.buttonColor,this.iconColor, this.icon,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: const Color(MyColor.colorWhite),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            spreadRadius: 6,
            blurRadius: 12,
            color: const Color(MyColor.colorGrey0).withOpacity(0.4),
          )
        ]
      ),
      padding: EdgeInsets.all(ScreenSize(context).heightOnly(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: ScreenSize(context).heightOnly(4.3),
                  width: ScreenSize(context).heightOnly(4.3),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10),),
                    color: Color(iconColor??MyColor.colorGreen),
                  ),
                  child: Icon(icon??Icons.update,color: const Color(MyColor.colorWhite),size: ScreenSize(context).heightOnly( 2.6),)
              ),
              SizedBox(width: ScreenSize(context).heightOnly( 1.0),),
              Expanded(
                child: Text(
                  header??"",
                  style: GetFont.get(
                      context,
                      fontSize:1.8,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorBlack
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenSize(context).heightOnly( 2.0),
          ),
          Text(
            text??'',
            style: GetFont.get(
                context,
                fontSize:2.2,
                fontWeight: FontWeight.w600,
                color: MyColor.colorBlack
            ),
          ),
          SizedBox(
            height: ScreenSize(context).heightOnly(1.4),
          ),
          Expanded(
            key: Key('$enabled check'),
            child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Material(
                  color: enabled==true?Color(buttonColor??MyColor.colorGreen):Color(buttonColor??MyColor.colorGreen).withOpacity(0.4),
                  child: InkWell(
                    onTap: enabled==true?onPressed:null,
                    splashColor: const Color(MyColor.colorGrey0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(1)),
                      child: Center(
                        child: Text(
                          buttonText??"",
                          style: GetFont.get(
                              context,
                              fontSize: 1.5,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorWhite
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
