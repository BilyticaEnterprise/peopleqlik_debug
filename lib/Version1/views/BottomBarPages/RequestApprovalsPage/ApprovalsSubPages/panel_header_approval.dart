import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/sliding_up_panel.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

class ApprovalsPanelHeader extends StatelessWidget {
  ApprovalsPanelHeader({Key? key}) : super(key: key);

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
                    onTap: (){
                      Provider.of<ApprovalCollector>(context,listen: false).panelController?.close();
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
                      '${CallLanguageKeyWords.get(context, LanguageCodes.approvalFilterPanelHeader)}',
                      style: GetFont.get(
                          context,
                          fontSize:2.2,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                      ),

                    ),

            ),
          ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: ClipRRect(
          //     borderRadius: const BorderRadius.all(Radius.circular(8)),
          //     child: Material(
          //       color: const Color(MyColor.colorPrimary),
          //       child: InkWell(
          //         splashColor: const Color(MyColor.colorGrey0),
          //         onTap: (){
          //           Provider.of<ApprovalCollector>(context,listen: false).panelController?.close();
          //         },
          //         child: Padding(
          //           padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1.4),vertical: ScreenSize(context).heightOnly( 0.6)),
          //           child: Text(
          //             'Confirm',
          //             style: GetFont.get(
          //                 context,
          //                 fontSize:1.3,
          //                 color: MyColor.colorWhite,
          //                 fontWeight: FontWeight.w600
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
