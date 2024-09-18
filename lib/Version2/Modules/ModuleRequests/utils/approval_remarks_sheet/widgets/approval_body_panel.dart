import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_accept_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/TextFields/LegacyTextFields/header_textfield.dart';
import 'package:peopleqlik_debug/utils/TextFieldRemarks/text_remarks_header.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';

class ApprovalsRemarksBody extends StatefulWidget {
  final AcceptReject acceptReject;

  const ApprovalsRemarksBody({required this.acceptReject,Key? key}) : super(key: key);

  @override
  State<ApprovalsRemarksBody> createState() => _ApprovalsRemarksBodyState();
}

class _ApprovalsRemarksBodyState extends State<ApprovalsRemarksBody> {
  FocusScopeNode? nodeFocus;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    nodeFocus = FocusScopeNode();
    super.initState();
  }
  @override
  void dispose() {
    nodeFocus?.dispose();
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: SizedBox(
        height: ScreenSize(context).heightOnly(78),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ScreenSize(context).heightOnly(2),),
              Expanded(
                child: HeaderTextRemarksField('${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarks)}','${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarksHint)}',textEditingController,nodeFocus!,false,callBack: remarksCallback,key: const Key('remarkssan'),)
              ),
              SizedBox(height: ScreenSize(context).heightOnly( 6),),
              ButtonWidget(text: widget.acceptReject==AcceptReject.reject?'${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelButton1)}':'${CallLanguageKeyWords.get(context, LanguageCodes.approvalBodyPanelButton2)}',buttonColor: widget.acceptReject==AcceptReject.reject?MyColor.colorBlack:MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: confirmPressed,),
              SizedBox(height: ScreenSize(context).heightOnly( window.viewPadding.bottom>0?4:6),),
            ],
        
        ),
      ),
    );
  }

  void remarksCallback(String data)
  {
   // widget.approvalsDetailCollector?.remarksAdd(data);
  }
  Future<void> confirmPressed()
  async {

    if(widget.acceptReject == AcceptReject.reject&&textEditingController.text.isEmpty)
      {
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError11)}');
      }
    else
      {
        Navigator.pop(context,textEditingController.text);
      }
  }
}
