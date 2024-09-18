import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/utils/lottie_anims_utils/lottie_string.dart';
import 'package:peopleqlik_debug/utils/pdf_viewer/src/controller/pdf_bloc.dart';
import 'package:peopleqlik_debug/utils/pdf_viewer/src/model/pdf_view_model.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

class PdfViewerImage extends StatelessWidget {

  final String fileName;
  const PdfViewerImage({required this.fileName,super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<PdfBloc>(create: (_) => PdfBloc(PdfViewModel(totalPage: 0,currentPage: 0)))
      ],
      builder: (context) {
        return _PdfView(fileName: fileName);
      }
    );
  }
}

class _PdfView extends StatelessWidget {
  final String fileName;
  const _PdfView({required this.fileName,super.key});

  @override
  Widget build(BuildContext context) {
    PdfBloc bloc = BlocProvider.of<PdfBloc>(context,listen: false);
    LanguageEnum languageEnum = Provider.of<ChangeLanguage>(context,listen: false).languageEnum;
    return Stack(
      children: [
        PDF(
          enableSwipe: true,
          swipeHorizontal: false,
          pageFling: Platform.isAndroid?true:true,
          autoSpacing: true,
          fitPolicy: FitPolicy.WIDTH,
          onViewCreated: (pdfViewController) async {
            bloc.updateController(pdfViewController);
          },
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onPageChanged: (int? page, int? total) {
            bloc.updatePages(page,total);
            print('page change: $page/$total');
          },
        ).cachedFromUrl(
            fileName,
            placeholder: (progress) => const Center(child: CircularIndicatorCustomized()),
            errorWidget: (error) => NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30)
        ),
        Align(
          alignment: languageEnum == LanguageEnum.english?Alignment.bottomRight:Alignment.bottomLeft,
          child: BlocConsumer<PdfBloc, PdfViewModel>(
              listener: (context,data){},
              builder: (context, data) {
                return SafeArea(
                  bottom: true,
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.all(ScreenSize(context).widthOnly(7)),
                    child: RichText(
                        text: TextSpan(
                          text: '${data.currentPage}',
                            style: GetFont.get(
                                context,
                                fontSize: 1.8,
                                fontWeight: data.currentPage == data.totalPage?FontWeight.w600:FontWeight.w400,
                                color: MyColor.colorBlack
                            ),
                          children: [
                            TextSpan(
                              text: '/${data.totalPage}',
                              style: GetFont.get(
                                  context,
                                  fontSize: 1.8,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorBlack
                              ),
                            )
                          ]
                        ),
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }
}
