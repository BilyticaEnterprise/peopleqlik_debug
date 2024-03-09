import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/ShiftListener/shift_detail_listener.dart';
import 'package:provider/provider.dart';

import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import '../../../../../../../Version1/Models/RequestsModel/request_data_taker.dart';
import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';

import '../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/lottie_anims_utils/lottie_string.dart';
import '../../../../../../../utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import '../../../../../../../../utils/ScreenLoader/circular_indicator_customized.dart';
import '../../../ApprovalsSubPages/ApprovalsAcceptance/CommonWidgets/approval_list_widget.dart';
import 'UiWidgets/shift_detail_widget.dart';

class ShiftDetailPage extends StatelessWidget {
  ShiftDetailPage({Key? key}) : super(key: key);
  RequestDataTaker? requestDataTaker;

  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)!.settings.arguments as RequestDataTaker;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ShiftDetailListener>(create: (_) => ShiftDetailListener(requestDataTaker?.documentNumber.toString()))
        ],
        builder: (context, snapshot) {
          return GetPageStarterScaffoldStateLess(
            title: '${requestDataTaker?.title??''}',
            body: BodyData(),
          );
        }
    );
  }
}
class BodyData extends StatefulWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ShiftDetailListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ShiftDetailListener>(
        builder: (context, data, child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 2), ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly(4)),
                    child: ShiftDetailWidget(data: data.requestDetail),
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 1),),
                  if(data.uniqueList!=null&&data.uniqueList!.isNotEmpty&&data.approvalsList!=null&&data.approvalsList!.isNotEmpty)...
                  [
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                      child: Text(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.ApprovalHistory)}',
                        style: GetFont.get(
                            context,
                            fontWeight: FontWeight.w700,
                            fontSize: 2.2,
                            color: MyColor.colorBlack
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 1.5),),
                    Flexible(
                        flex: 1,
                        child: ApprovalListWidget(data.approvalsList)
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly(16),),
                  ],
                ],
              ),
            );
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable(LottieString.notAvailable, '${CallLanguageKeyWords.get(context, LanguageCodes.noInfoAvailableHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.noInfoAvailableValue)}',topMargin: 8,width: 40,);
          }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
}
