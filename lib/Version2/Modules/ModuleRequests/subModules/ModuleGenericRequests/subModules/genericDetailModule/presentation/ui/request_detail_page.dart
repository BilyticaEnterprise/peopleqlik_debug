import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleGenericRequests/subModules/genericDetailModule/presentation/listener/get_general_request_detail_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/applied_for_employee_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_history_view.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/lottie_anims_utils/lottie_string.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class RequestDetailPage extends StatelessWidget {
  RequestDetailPage({Key? key}) : super(key: key);
  late AllRequestDetailMapper allRequestDetailMapper;

  @override
  Widget build(BuildContext context) {
    allRequestDetailMapper = ModalRoute.of(context)!.settings.arguments as AllRequestDetailMapper;
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<GeneralRequestDetailBloc>(create: (_) => GeneralRequestDetailBloc(AppStateNothing(), allRequestDetailMapper: allRequestDetailMapper,),)
      ],
      builder: (context) {
        return GetPageStarterScaffoldStateLess(
            title: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsDetail)}',
            body: BodyData(allRequestDetailMapper)
        );
      }
    );
  }
}
class BodyData extends StatefulWidget {
  final AllRequestDetailMapper allRequestDetailMapper;
  const BodyData(this.allRequestDetailMapper, {Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<GeneralRequestDetailBloc>(context,listen: false).fetchGeneralRequestDetail(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralRequestDetailBloc,AppState>(
      listener: (context,data){},
        builder: (context,data) {
          if(data is AppStateDone)
          {
            return BodyDataNow(widget.allRequestDetailMapper);
          }
          else if(data is AppStateEmpty)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableH)}', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableA)}',topMargin: 8,width: 30);
          }
          else if(data is AppStateError)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableH)}', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableA)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
}
class BodyDataNow extends StatelessWidget {
  final AllRequestDetailMapper allRequestDetailMapper;
  BodyDataNow(this.allRequestDetailMapper, {Key? key}) : super(key: key);

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    GeneralRequestDetailBloc data = BlocProvider.of<GeneralRequestDetailBloc>(context,listen: false);
    return SizedBox(
      height: ScreenSize(context).heightOnly( 100),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(data.useCase.getGeneralRequestDetailResult()!=null&&data.useCase.getGeneralRequestDetailResult()?.admRequestMf?.admRequestFile!=null&&data.useCase.getGeneralRequestDetailResult()!.admRequestMf!.admRequestFile!.isNotEmpty)...[
              SizedBox(
                height: ScreenSize(context).heightOnly( 24),
                child: Swiper(
                  itemHeight: ScreenSize(context).heightOnly( 10),
                  autoplay: true,
                  itemBuilder: (BuildContext context, int indexYe) {
                    //PrintLogs.print('${RequestType.requestUrl}${data.requestNamesResultSet?[0].admRequestFile?[indexYe].fileName}');
                    return CachedNetworkImage(
                        imageUrl: '${RequestType.requestUrl}${data.useCase.getGeneralRequestDetailResult()?.admRequestMf?.admRequestFile?[indexYe].fileName}',
                        imageBuilder: (context, imageProvider) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color(MyColor.colorWhite),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(MyColor.colorWhite),
                            borderRadius: BorderRadius.all(Radius.circular(15)),

                          ),
                          child: const ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              child: Center(child: CircularProgressIndicator())
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(MyColor.colorGrey0),
                              borderRadius: BorderRadius.all(Radius.circular(15)),

                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              child: Image.asset('assets/logo.png',fit: BoxFit.fitWidth,
                              ),
                            )
                        )
                    );
                  },
                  onTap: (pos){
                    Navigator.pushNamed(context, CurrentPage.ProductImageZoom,arguments: '${RequestType.requestUrl}${data.useCase.getGeneralRequestDetailResult()?.admRequestMf?.admRequestFile?[pos].fileName}');
                  },
                  itemCount: data.useCase.getGeneralRequestDetailResult()?.admRequestMf?.admRequestFile?.length??0,
                  viewportFraction: 0.75,
                  scale: 0.85,
                ),
              ),
              SizedBox(height: ScreenSize(context).heightOnly( 2),)
            ],
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly( 4)),
                itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: const Color(MyColor.colorBackgroundDark),
                            width: 0.7
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.useCase.getGeneralRequestDetailResult()?.admRequestMf?.admRequestValue?[index].admRequestManagerDt?.title??'${CallLanguageKeyWords.get(context, LanguageCodes.File)} ${index+1}',
                              style: GetFont.get(
                                  context,
                                  fontSize:1.8,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.colorBlack
                              ),
                          ),
                          SizedBox(height: ScreenSize(context).widthOnly( 2),),
                          Flexible(
                            flex:0,
                            child: Text(
                              data.useCase.getGeneralRequestDetailResult()?.admRequestMf?.admRequestValue?[index].controlValue??'',
                              style: GetFont.get(
                                  context,
                                  fontSize:1.8,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorBlack
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context,index){return SizedBox(height: ScreenSize(context).heightOnly( 2),);},
                itemCount: data.useCase.getGeneralRequestDetailResult()?.admRequestMf?.admRequestValue?.length??0
            ),
            const DividerByHeight(3),
            AppliedForEmployeeWidget(data: data.useCase.getGeneralRequestDetailResult()?.appliedForEmployee),
            const DividerByHeight(1),
            ApprovalHistoryView(approvalList: data.useCase.getApprovalListForView()),
            if(data.useCase.canAdminApprove() == true && allRequestDetailMapper.isApprovalScreen == true)...[
              SizedBox(height: ScreenSize(context).heightOnly( 4),),
              ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.announcementReject)}',buttonColor: MyColor.colorBlack,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: rejectPressed,),
              SizedBox(height: ScreenSize(context).heightOnly( 2),),
              ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.approvalBodyPanelButton2)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: approvePressed,),
              SizedBox(height: ScreenSize(context).heightOnly( 6),),
            ],

            SizedBox(height: ScreenSize(context).heightOnly( 10),),

          ],
        ),
      ),
    );
  }
  void rejectPressed()
  {
    BlocProvider.of<GeneralRequestDetailBloc>(context,listen: false).actionButtonPressed(context,AcceptReject.reject,3);
  }

  void approvePressed()
  {
    BlocProvider.of<GeneralRequestDetailBloc>(context,listen: false).actionButtonPressed(context,AcceptReject.accept,2);
  }
}


