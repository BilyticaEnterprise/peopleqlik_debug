import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';
import 'package:peopleqlik_debug/utils/pdf_viewer/src/model/pdf_view_model.dart';

class PdfBloc extends ExtendedCubit<PdfViewModel>
{
  PdfBloc(super.initialState);

  notifyPdfPage(PdfViewModel pdfViewModel)
  {
    emit(pdfViewModel);
  }

  Future<void> updateController(PDFViewController pdfViewController) async {
    int totalPage =  validateTotalPage(await pdfViewController.getPageCount());
    int? currentPage = validateCurrentPage(await pdfViewController.getCurrentPage());
    notifyPdfPage(PdfViewModel(totalPage: totalPage,currentPage: currentPage??0));
  }

  int validateTotalPage(int? totalPage)
  {
    if(totalPage == null)
      {
        return 0;
      }
    return totalPage;
  }

  int validateCurrentPage(int? page)
  {
    if(page == null)
    {
      return 0;
    }
    return page+1;
  }

  void updatePages(int? page, int? total) {
    notifyPdfPage(PdfViewModel(totalPage: validateTotalPage(total),currentPage: validateCurrentPage(page)));
  }

}