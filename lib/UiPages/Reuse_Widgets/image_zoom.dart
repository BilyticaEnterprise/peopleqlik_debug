
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductImageZoom extends StatefulWidget {
  @override
  _ProductImageZoomState createState() => _ProductImageZoomState();
}

class _ProductImageZoomState extends State<ProductImageZoom> {
  String? productImage;
  @override
  Widget build(BuildContext context) {
    productImage = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(MyColor.colorWhite),
        titleSpacing: 0,
        elevation: 0,
        title: AppBarWidget('Zoom'),
      ),
      body: PhotoView(
        backgroundDecoration: const BoxDecoration(
            color: Color(MyColor.colorBlack)
        ),
        imageProvider: NetworkImage('$productImage'),
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
      ),
    );
  }
}
