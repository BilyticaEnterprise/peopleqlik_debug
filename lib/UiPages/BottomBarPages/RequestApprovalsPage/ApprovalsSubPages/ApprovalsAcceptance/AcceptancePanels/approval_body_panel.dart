import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Approvals/approvals_accept_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Buttons/buttons.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/header_textfield.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/text_remarks_header.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';

class ApprovalsDetailBody extends StatefulWidget {
  final ApprovalsAcceptRejectCollector? acceptRejectCollector;
  final ApprovalsDetailCollector? approvalsDetailCollector;
  final Function() callback;
  const ApprovalsDetailBody({required this.acceptRejectCollector,required this.approvalsDetailCollector,required this.callback,Key? key}) : super(key: key);

  @override
  State<ApprovalsDetailBody> createState() => _ApprovalsDetailBodyState();
}

class _ApprovalsDetailBodyState extends State<ApprovalsDetailBody> {
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: ScreenSize(context).heightOnly(2),),
        Expanded(
          child: HeaderTextRemarksField('${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarks)}','${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarksHint)}',textEditingController,nodeFocus!,false,callBack: remarksCallback,key: const Key('remarkssan'),)
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 6),),
        ButtonWidget(text: widget.approvalsDetailCollector?.acceptReject==AcceptReject.reject?'${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelButton1)}':'${CallLanguageKeyWords.get(context, LanguageCodes.approvalBodyPanelButton2)}',buttonColor: widget.approvalsDetailCollector?.acceptReject==AcceptReject.reject?MyColor.colorBlack:MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: confirmPressed,),
        SizedBox(height: ScreenSize(context).heightOnly( window.viewPadding.bottom>0?4:6),),

      ],
    );
  }

  void remarksCallback(String data)
  {
    widget.approvalsDetailCollector?.remarksAdd(data);
  }
  Future<void> confirmPressed()
  async {

    if(widget.approvalsDetailCollector?.acceptReject == AcceptReject.reject&&widget.approvalsDetailCollector!.remarks.isEmpty)
      {
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError11)}');
      }
    else
      {
        Navigator.pop(context);
        /// Means okay done submit now
        widget.callback();
      }
  }
}
