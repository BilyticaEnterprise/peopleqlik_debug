import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_calendar_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_detail_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_form_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Buttons/buttons.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/text_remarks_header.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import 'SeparationFormWidgets/datepicker_widget.dart';

class SeparationCalendarPage extends StatelessWidget {
  SeparationCalendarPage({Key? key}) : super(key: key);
  RequestSeparationDetailData? requestDetailData;
  @override
  Widget build(BuildContext mContext) {
    requestDetailData = ModalRoute.of(mContext)!.settings.arguments as RequestSeparationDetailData;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GetRequestSeparationCalendarListener>(create: (_) => GetRequestSeparationCalendarListener(),)
      ],
      child: Scaffold(
          backgroundColor: const Color(MyColor.colorWhite),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: false,
                    floating: true,
                    backgroundColor: const Color(MyColor.colorWhite),
                    snap: true,
                    elevation: 2,
                    titleSpacing: 0,
                    title: AppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.requestsDetail)}')
                ),
              ];
            },
            body: Consumer<CheckInternetConnection>(
                builder: (context,data,child) {
                  if(data.internetConnectionEnum == InternetConnectionEnum.available)
                  {
                    return BodyData(requestDetailData,context);
                  }
                  else
                  {
                    return NotAvailable(GetVariable.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
                  }
                }
            ),
          )
      ),
    );
  }
}
class BodyData extends StatefulWidget {
  final RequestSeparationDetailData? requestDetailData;
  final BuildContext mContext;
  const BodyData(this.requestDetailData, this.mContext, {Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  FocusScopeNode? focusScopeNode;
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    focusScopeNode?.dispose();
    textEditingController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    textEditingController = TextEditingController();
    focusScopeNode = FocusScopeNode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    GetRequestSeparationCalendarListener getRequestSeparationCalendarListener = Provider.of<GetRequestSeparationCalendarListener>(context,listen: false);
    getRequestSeparationCalendarListener.requestSeparationDetailData ??= widget.requestDetailData;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalenderSeparationTimeWidget(RequestSeparationData(index: 1,title: CallLanguageKeyWords.get(context, LanguageCodes.separationEffectiveDate)??'',data: widget.requestDetailData?.lastWorkingDate,isEnable: false,isRequired: true,callBack: callback,hint: '${CallLanguageKeyWords.get(context, LanguageCodes.select)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationEffectiveDate)}'),key: const Key('1text'),),
          SizedBox(height: ScreenSize(context).heightOnly( 2),),
          CalenderSeparationTimeWidget(RequestSeparationData(index: 2,title: CallLanguageKeyWords.get(context, LanguageCodes.separationLastWorkingDate)??'',data: null,isEnable: true,isRequired: true,callBack: callback,hint: '${CallLanguageKeyWords.get(context, LanguageCodes.select)} ${CallLanguageKeyWords.get(context, LanguageCodes.separationEffectiveDate)}'),key: const Key('2text'),),
          SizedBox(height: ScreenSize(context).heightOnly( 2),),
          Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                child: HeaderTextRemarksField('${CallLanguageKeyWords.get(context, LanguageCodes.separationJustification)}','${CallLanguageKeyWords.get(context, LanguageCodes.separationWriteSome)}',textEditingController,focusScopeNode!,true,callBack: remarksCallback,key: const Key('remarkssan'),fromSeparation: true,paddingIs: 0,margin: 0,),
              ),
            ],
          ),
          SizedBox(height: ScreenSize(context).heightOnly( 4),),
          ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsaddFormButton)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: confirmPressed,),
          SizedBox(height:ScreenSize(context).heightOnly(16),),

        ],
      ),
    );
  }

  callback(RequestSeparationCallBack data) {
    print('indexaya ${data.index} ${data.data}');
    if(data.index==2)
      {
        Provider.of<GetRequestSeparationCalendarListener>(context,listen: false).updateLastDate(data.data);
      }
  }

  void confirmPressed() {
    Provider.of<GetRequestSeparationCalendarListener>(widget.mContext,listen: false).submit(context);
  }

  remarksCallback(String remarks) {
    Provider.of<GetRequestSeparationCalendarListener>(context,listen: false).updateRemarks(remarks);
  }
}
