import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peopleqlik_debug/Version1/Models/PaysSlipApprovalsRequest/request_list_form_model.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/request_form_get_listener.dart';
import 'package:peopleqlik_debug/utils/TextFields/LegacyTextFields/text_widgets.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class RequestTextField extends StatefulWidget {
  final FocusScopeNode nodeFocus;
  final Function(RequestCallBack)? textCallBack;
  final RequestSender? requestSender;

  const RequestTextField(this.requestSender,this.textCallBack,this.nodeFocus,{Key? key}) : super(key: key);

  @override
  State<RequestTextField> createState() => _RequestTextFieldState();
}

class _RequestTextFieldState extends State<RequestTextField> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    if(widget.requestSender?.data!=null&&widget.requestSender!.data!.isNotEmpty&&widget.requestSender?.data?[0].name!=null)
    {
      textEditingController.text = '${widget.requestSender?.data?[0].name}';
      response(textEditingController.text);
    }
    super.initState();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
            child:
            Row(children: [
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
        TextWidget(textEditingController,TextInputAction.done,widget.nodeFocus, Key('Key${widget.requestSender?.header}'),widget.requestSender?.hint,padding: 4,stroke: 0.8,height: 6.2,callBack: response,isEnabled:widget.requestSender?.isEnable),
      ],
    );
  }

  void response(String text)
  {
    //PrintLogs.printLogs('texttttyeuii $text');
    ReqDetail? detail = ReqDetail();
    detail.name = text;
    detail.id = widget.requestSender?.data?[0].id??-1;
    widget.textCallBack!(RequestCallBack(detail,widget.requestSender?.uiIndex,widget.requestSender?.dataIndex,widget.requestSender?.uiTypes,widget.requestSender?.dependent,widget.requestSender?.isEnable,widget.requestSender?.admRequestManagerDt));
  }
}