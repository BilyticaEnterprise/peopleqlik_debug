import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/data/model/document_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/presentation/bloc/document_fetch_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/presentation/bloc/document_filters_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/presentation/ui/widgets/document_policy_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/presentation/ui/widgets/filtersWidget/filter_icon_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/domain/model/document_policy_acknowledge_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/presentation/ui/document_acknowledgement_bottom_sheet.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentFilterModule/presentation/ui/document_filter_view_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/utils/document_constants.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/model/file_downloader_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/presentation/bloc/file_downloader_bloc.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/skeleton_list_widget.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/bottomSheetUi/bottom_sheet_ui.dart';
import 'package:peopleqlik_debug/utils/checkFileTypeFromUrl/check_file_type.dart';
import 'package:peopleqlik_debug/utils/checkFileTypeFromUrl/src/file_enums.dart';
import 'package:peopleqlik_debug/utils/default_Screens/bottom_sheet_screens/bottom_sheet_screen.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/utils/lottie_anims_utils/lottie_string.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class DocumentMainPage extends StatelessWidget {
  DocumentMainPage({super.key});

  bool popped = false;
  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<DocumentFiltersTypeIdBloc>(create: (_) => DocumentFiltersTypeIdBloc(DocumentPolicyConstants.defaultTypeId)),
          BlocProvider<DocumentFetchBloc>(create: (_) => DocumentFetchBloc(AppStateNothing(),context)),
        ],
        builder: (context) {
          return PopScope(
            canPop: false,
            onPopInvoked: (value){
              bool updatePrevious = BlocProvider.of<DocumentFetchBloc>(context,listen: false).updatePreviousPage;

              if(popped==false&&Navigator.canPop(context))
                {
                  popped = true;
                  Navigator.pop(context, updatePrevious);
                }
            },
            child: GetPageStarterScaffoldStateLess(
              title: CallLanguageKeyWords.get(context, LanguageCodes.documentsPage),
              onBackTap: (){
                bool updatePrevious = BlocProvider.of<DocumentFetchBloc>(context,listen: false).updatePreviousPage;
                Navigator.pop(context,updatePrevious);
              },
              action: FilterIconWidget(
                onTap: () {
                  DraggableScrollableController controller = DraggableScrollableController();

                  ShowBottomSheet.show(
                      context,
                      height: 90,
                      draggableScrollableController: controller,
                      builder: DefaultBottomSheetScreen(
                        body: DocumentFilterWidget(defaultSelectedTypeId: BlocProvider.of<DocumentFiltersTypeIdBloc>(context,listen: false).getCurrentTypeId(),),
                      ),
                      callBack: (value)
                      {
                        if(value != null&& value is int)
                        {
                          BlocProvider.of<DocumentFiltersTypeIdBloc>(context,listen: false).updateSelectedTypeId(value);
                          BlocProvider.of<DocumentFetchBloc>(context,listen: false).updateFetchDocumentApiModel(context,value);
                        }
                      }
                  );
                },
              ),
              body: _BodyData(),
            ),
          );
        }
    );
  }
}
class _BodyData extends StatefulWidget {
  const _BodyData({super.key});

  @override
  State<_BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<_BodyData> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<DocumentFetchBloc>(context,listen: false).fetchListNotification(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentFetchBloc,AppState>(
        listener: (context,data){},
        builder: (context,data) {
          if(data is AppStateDone || data is AppStatePagination)
          {
            DocumentFetchBloc getNotificationModelListener = BlocProvider.of<DocumentFetchBloc>(context,listen: false);
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification){
                // PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                {
                  // PrintLogs.print('true');
                  getNotificationModelListener.useCase.updateStep(true, context);
                  return true;
                }
                else
                {
                  getNotificationModelListener.useCase.updateStep(false, context);
                  return false;
                }
              },
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: ScreenSize(context).heightOnly(4),bottom: ScreenSize(context).heightOnly( 20)),
                  itemBuilder: (context,index)
                  {
                    ObjDocument? objDocument = getNotificationModelListener.useCase.getList()?[index];
                    FileTypeEnum fileTypeEnum = CheckFileType.checkFileType(objDocument?.fileName);
                    PrintLogs.printLogs('ashdajshbdjhs ${RequestType.documentUrl}');

                    return getNotificationModelListener.useCase.getIsReachEnd() == true && index==getNotificationModelListener.useCase.getList()!.length-1?

                    SkeletonListWidget(index,height: 12,margin: 5.6,):

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6)),
                      child: DashboardDocumentPolicyWidget(
                        isDummy: false,
                        onTapNext: (){
                          getNotificationModelListener.gotToNextDetailPage(context,index);
                        },
                        data: objDocument,
                        onDownloadTap: (){
                          BlocProvider.of<FileDownloaderBloc>(context,listen: false).initializeDownloading(
                              context: context,
                              fileDownloaderModel: FileDownloaderModel(
                                  baseUrl: '${RequestType.documentUrl}',
                                  fileName: '${objDocument?.documentTitle}',
                                  urlToDownload: '${objDocument?.fileName}'
                              )
                          );
                        },
                        onAcknowledgeTap: (){
                          ShowDocumentBottomSheet.show(context: context,
                              model: DocumentPolicyAcknowledgeModel(
                                  id: objDocument?.documentCode,
                                  title: objDocument?.documentTitle,
                                  htmlText: objDocument?.acknowledgementBody
                              ),
                              onDoneCallBack: (){
                                BlocProvider.of<DocumentFetchBloc>(context,listen: false).updatePreviousPageMethod();
                                BlocProvider.of<DocumentFetchBloc>(context,listen: false).fetchListNotification(context);
                              }
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context,index)
                  {
                    return SizedBox(height: ScreenSize(context).heightOnly(2.5),);
                  },
                  itemCount: getNotificationModelListener.useCase.getList()?.length??0
              ),
            );
          }
          else if(data is AppStateEmpty)
          {
            return NotAvailable(LottieString.notAvailable, '${CallLanguageKeyWords.get(context, LanguageCodes.noDocumentHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.noDocumentValue)}',topMargin: 8,width: 40,);
          }
          else if(data is AppStateError)
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
