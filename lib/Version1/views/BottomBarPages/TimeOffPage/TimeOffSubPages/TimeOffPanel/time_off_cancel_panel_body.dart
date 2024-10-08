import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_accept_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/presentation/listener/post_time_off_cancel_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/time_off_cancel_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_model.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/TextFields/LegacyTextFields/header_textfield.dart';
import 'package:peopleqlik_debug/utils/TextFieldRemarks/text_remarks_header.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';

class LeaveCancelBody extends StatefulWidget {
  const LeaveCancelBody({Key? key}) : super(key: key);

  @override
  State<LeaveCancelBody> createState() => _LeaveCancelBodyState();
}

class _LeaveCancelBodyState extends State<LeaveCancelBody> {
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
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Expanded(
          child: HeaderTextRemarksField('${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarks)}','${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarksHint)}',textEditingController,nodeFocus!,false,callBack: remarksCallback,key: const Key('remarkssanTsada'),),
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 6),),
        ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.confirm)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: confirmPressed,),
        SizedBox(height: ScreenSize(context).heightOnly( window.viewPadding.bottom>0?4:6),),

      ],
    );
  }

  void remarksCallback(String data)
  {
   // Provider.of<TimeOffCancelCollector>(context,listen: false).cancelLeaveJson?.cancelLeaveRemarks = data;
  }
  Future<void> confirmPressed()
  async {

    if(textEditingController.text.isEmpty&&textEditingController.text.replaceAll(' ', '').isEmpty)
      {
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffError11)}',bottom: 16);
      }
    else
    {
      Navigator.pop(context,textEditingController.text);
    }
  }
}
