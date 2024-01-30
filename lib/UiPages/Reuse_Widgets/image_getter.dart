import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../src/colors.dart';

import '../../src/get_assets.dart';
import '../../src/screen_sizes.dart';

class GetNetWorkImage extends StatelessWidget {
  final String? image;
  final String? baseUrl;
  final double? size,width;
  final double? radius;
  final bool? isUserLive;
  final bool? showLiveIcon;
  final BoxShape? boxShape;
  final BoxFit? boxFit;
  final int? borderColor,backgroundColor;
  final bool? withBorder;
  final bool? vintageImage;

  const GetNetWorkImage({required this.image,this.showLiveIcon,this.isUserLive,this.width,this.vintageImage,this.backgroundColor,this.borderColor,this.withBorder,this.boxFit,this.boxShape = BoxShape.circle,this.radius,this.size,this.baseUrl,Key? key}) : assert(boxShape == BoxShape.rectangle||boxShape == BoxShape.circle,'If boxShape is rectangle then set radius too'), super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: baseUrl!=null?'${baseUrl}${image}':image??'',
        imageBuilder: (context, imageProvider) => Container(
            width:width??ScreenSize(context).heightOnly(size??7),
            height: ScreenSize(context).heightOnly(size??7),
            decoration: BoxDecoration(
              shape: boxShape==BoxShape.rectangle?BoxShape.rectangle:BoxShape.circle,
              color: Color(backgroundColor??MyColor.colorGrey6),
              borderRadius: boxShape==BoxShape.rectangle?BorderRadius.all(Radius.circular(radius??15)):null,
              border: withBorder==true?Border.all(
                  width: 0.8,
                  color: Color(borderColor??MyColor.colorWhite)
              ):null,
              image: DecorationImage(
                image: imageProvider,
                fit: boxFit??BoxFit.cover,
              ),
            )
        ),
        placeholder: (context, url) => Container(
          width:width??ScreenSize(context).heightOnly(size??7),
          height: ScreenSize(context).heightOnly(size??7),
          decoration: BoxDecoration(
            shape: boxShape==BoxShape.rectangle?BoxShape.rectangle:BoxShape.circle,
            color: Color(backgroundColor??MyColor.colorGrey6),
            borderRadius: boxShape==BoxShape.rectangle?BorderRadius.all(Radius.circular(radius??15)):null,
            border: withBorder==true?Border.all(
                width: 0.8,
                color: Color(borderColor??MyColor.colorBlack)
            ):null,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(boxShape==BoxShape.rectangle?(radius??15):100)),
              child: const Center(child: CircularProgressIndicator())
          ),
        ),
        errorWidget: (context, url, error) => Container(
            width: width??ScreenSize(context).heightOnly(size??7),
            height: ScreenSize(context).heightOnly(size??7),
            decoration: BoxDecoration(
              shape: boxShape==BoxShape.rectangle?BoxShape.rectangle:BoxShape.circle,
              color: Color(backgroundColor??MyColor.colorGrey6),
              borderRadius: boxShape==BoxShape.rectangle?BorderRadius.all(Radius.circular(radius??15)):null,
              border: withBorder==true?Border.all(
                  width: 0.8,
                  color: Color(borderColor??MyColor.colorBlack)
              ):null,
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly(4)),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(boxShape==BoxShape.rectangle?(radius??15):100)),
                child: Image.asset(GetAssets.avatar,fit: BoxFit.contain,
                ),
              ),
            )
        )
    );

  }
}
