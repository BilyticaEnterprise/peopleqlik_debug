import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/Version1/Models/PaysSlipApprovalsRequest/request_list_form_model.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../request_form_get_listener.dart';

class RequestCheckBoxWidget extends StatefulWidget {
  final RequestSender? requestSender;
  final Function(RequestCallBack)? callBack;
  const RequestCheckBoxWidget(this.requestSender,this.callBack,{Key? key}) : super(key: key);

  @override
  _RequestCheckBoxWidgetState createState() => _RequestCheckBoxWidgetState();
}

class _RequestCheckBoxWidgetState extends State<RequestCheckBoxWidget> {
  bool paymentMethod = false;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
            child: Row(children: [
              Text(
                widget.requestSender?.header??'',
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
            ],)
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Container(
          height: ScreenSize(context).heightOnly( 6.5),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                  color: const Color(MyColor.colorBlack),
                  width: 0.7
              )
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: Material(
              color: Color(widget.requestSender?.isEnable==false?MyColor.colorGreySecondary:MyColor.colorTransparent),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 4)),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.requestSender?.hint??'',
                            style: GetFont.get(
                                context,
                                fontWeight: FontWeight.w400,
                                fontSize: 1.6,
                                color: MyColor.colorGrey3
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Switch(
                          value: paymentMethod,
                          onChanged: (value){
                            setState(() {
                              ReqDetail reqDetail;
                              if(paymentMethod)
                              {
                                reqDetail = ReqDetail();
                                reqDetail.id = -1;
                                reqDetail.name = false;
                                paymentMethod=false;
                              }
                              else
                              {
                                reqDetail = ReqDetail();
                                reqDetail.id = -1;
                                reqDetail.name = true;
                                paymentMethod=true;
                              }
                              widget.callBack!(RequestCallBack(reqDetail,widget.requestSender?.uiIndex,widget.requestSender?.dataIndex,widget.requestSender?.uiTypes,widget.requestSender?.dependent,widget.requestSender?.isEnable,widget.requestSender?.admRequestManagerDt));
                            });
                          },
                          activeTrackColor: const Color(MyColor.colorBackgroundDark),
                          activeColor: const Color(MyColor.colorPrimary).withOpacity(0.8),
                        ),
                      ],
                    )
                  ),
                ),
              ),
            ),
        )
      ],
    );
  }
  void change()
  {
    setState(() {
      ReqDetail reqDetail;
      if(paymentMethod)
      {
        reqDetail = ReqDetail();
        reqDetail.name = false;
        paymentMethod=false;
      }
      else
      {
        reqDetail = ReqDetail();
        reqDetail.name = true;
        paymentMethod=true;
      }
      widget.callBack!(RequestCallBack(reqDetail,widget.requestSender?.uiIndex,widget.requestSender?.dataIndex,widget.requestSender?.uiTypes,widget.requestSender?.dependent,widget.requestSender?.isEnable,widget.requestSender?.admRequestManagerDt));
    });
  }
}