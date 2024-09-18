import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/utils/lottie_anims_utils/lottie_string.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoomWidget extends StatelessWidget {
  final String? image;
  const ImageZoomWidget({required this.image,super.key});

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      backgroundDecoration: const BoxDecoration(
          color: Color(MyColor.colorBlack)
      ),
      imageProvider: NetworkImage('$image'),
      errorBuilder: (context, error, stack) => NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30),
      loadingBuilder: (context, event) => Center(
        child: SizedBox(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          ),
        ),
      ),
    );
  }
}
