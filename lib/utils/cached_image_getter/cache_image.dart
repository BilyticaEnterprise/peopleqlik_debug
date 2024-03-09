import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/configs/get_assets.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';

import '../../configs/colors.dart';
import '../screen_sizes.dart';

class GetNetWorkImage extends StatelessWidget {
  final String? image;
  final bool? isLocalImage;
  final String? baseUrl;
  final double? size,width,height;
  final double? radius;
  final bool? isUserLive;
  final bool? showLiveIcon;
  final EdgeInsets? edgeInsets;
  final double? marginHorizontal;
  final BoxShape? boxShape;
  final BoxFit? boxFit;
  final int? borderColor,backgroundColor;
  final bool? withBorder;
  final double? borderWidth;
  final bool? vintageImage;
  final double? borderPadding;
  final List<BoxShadow>? boxShadow;

  const GetNetWorkImage({this.borderWidth,required this.image,this.boxShadow,this.borderPadding,this.edgeInsets,this.marginHorizontal,this.showLiveIcon,this.isUserLive,this.isLocalImage = false,this.height,this.width,this.vintageImage,this.backgroundColor,this.borderColor,this.withBorder,this.boxFit,this.boxShape = BoxShape.rectangle,this.radius,this.size,this.baseUrl,Key? key}) : assert(boxShape == BoxShape.rectangle||boxShape == BoxShape.circle,'If boxShape is rectangle then set radius too'), super(key: key);

  @override
  Widget build(BuildContext context) {
    PrintLogs.printLogs('heighasd $height');
    if(isLocalImage==false)
      {
        return CachedNetworkImage(
            imageUrl: baseUrl!=null?'${baseUrl}${image}':image??'',
            imageBuilder: (context, imageProvider) => Container(
                width:width==null&&size==null?double.infinity:ScreenSize(context).heightOnly(width??size??7),
                height: height==null&&size==null?double.infinity:ScreenSize(context).heightOnly(height??size??7),
                margin: edgeInsets??EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(marginHorizontal??0)),
                decoration: BoxDecoration(
                  shape: boxShape==BoxShape.rectangle?BoxShape.rectangle:BoxShape.circle,
                  boxShadow: boxShadow,
                  color: Color(backgroundColor??MyColor.colorWhite),
                  borderRadius: boxShape==BoxShape.rectangle?BorderRadius.all(Radius.circular(radius??15)):null,
                  border: withBorder==true?Border.all(
                      width: borderWidth??1.0,
                      color: Color(borderColor??MyColor.colorWhite)
                  ):null,
                ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.all(ScreenSize(context).heightOnly(borderPadding??0)),
                decoration: BoxDecoration(
                  shape: boxShape==BoxShape.rectangle?BoxShape.rectangle:BoxShape.circle,
                  color: Color(backgroundColor??MyColor.colorWhite),
                  borderRadius: boxShape==BoxShape.rectangle?BorderRadius.all(Radius.circular(radius??15)):null,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: boxFit??BoxFit.cover,
                  ),
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              width:width==null&&size==null?double.infinity:ScreenSize(context).heightOnly(width??size??7),
              height: height==null&&size==null?double.infinity:ScreenSize(context).heightOnly(height??size??7),
              margin: edgeInsets??EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(marginHorizontal??0)),
              padding: EdgeInsets.all(ScreenSize(context).heightOnly(borderPadding??0)),
              decoration: BoxDecoration(
                shape: boxShape==BoxShape.rectangle?BoxShape.rectangle:BoxShape.circle,
                color: Color(backgroundColor??MyColor.colorWhite),
                boxShadow: boxShadow,
                borderRadius: boxShape==BoxShape.rectangle?BorderRadius.all(Radius.circular(radius??15)):null,
                border: withBorder==true?Border.all(
                    width: borderWidth??0.8,
                    color: Color(borderColor??MyColor.colorBlack)
                ):null,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(boxShape==BoxShape.rectangle?(radius??15):100)),
                  child: const Center(child: CircularProgressIndicator())
              ),
            ),
            errorWidget: (context, url, error) => Container(
                width:width==null&&size==null?double.infinity:ScreenSize(context).heightOnly(width??size??7),
                height: height==null&&size==null?double.infinity:ScreenSize(context).heightOnly(height??size??7),
                margin: edgeInsets??EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(marginHorizontal??0)),
                padding: EdgeInsets.all(ScreenSize(context).heightOnly(borderPadding??0)),
                decoration: BoxDecoration(
                  shape: boxShape==BoxShape.rectangle?BoxShape.rectangle:BoxShape.circle,
                  color: Color(backgroundColor??MyColor.colorWhite),
                  borderRadius: boxShape==BoxShape.rectangle?BorderRadius.all(Radius.circular(radius??15)):null,
                  boxShadow: boxShadow,
                  border: withBorder==true?Border.all(
                      width: borderWidth??0.8,
                      color: Color(borderColor??MyColor.colorBlack)
                  ):null,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(boxShape==BoxShape.rectangle?(radius??15):100)),
                    child: Image.asset(GetAssets.avatar,fit: BoxFit.cover,
                  ),
                )
            )
        );
      }
    else
      {

        return Container(
            width:width==null&&size==null?double.infinity:ScreenSize(context).heightOnly(width??size??7),
            height: height==null&&size==null?double.infinity:ScreenSize(context).heightOnly(height??size??7),
            margin: edgeInsets??EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(marginHorizontal??0)),
          padding: EdgeInsets.all(ScreenSize(context).heightOnly(borderPadding??0)),
          decoration: BoxDecoration(
              shape: boxShape==BoxShape.rectangle?BoxShape.rectangle:BoxShape.circle,
              boxShadow: boxShadow,
              color: Color(backgroundColor??MyColor.colorWhite),
              borderRadius: boxShape==BoxShape.rectangle?BorderRadius.all(Radius.circular(radius??15)):null,
              border: withBorder==true?Border.all(
                  width: borderWidth??0.8,
                  color: Color(borderColor??MyColor.colorWhite)
              ):null,

            ),
            child: boxShape==BoxShape.rectangle?
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(radius??15)),
              child: vintageImage==true?ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0), // Semi-transparent black at the top
                      Colors.black.withOpacity(0.4), // Semi-transparent black at the bottom
                      Colors.black.withOpacity(0.6), // Semi-transparent black at the bottom
                    ],
                  ).createShader(bounds);
                  },
                blendMode: BlendMode.srcATop,
                child: Image.asset(image??GetAssets.avatar,fit: BoxFit.cover,),
              ):
              Image.asset(image??GetAssets.avatar,fit: BoxFit.cover,),
            ):

            vintageImage==true?ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0), // Semi-transparent black at the top
                    Colors.black.withOpacity(0.4), // Semi-transparent black at the bottom
                    Colors.black.withOpacity(0.6), // Semi-transparent black at the bottom
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: Image.asset(image??GetAssets.avatar,fit: BoxFit.cover,),
            ):
            Image.asset(image??GetAssets.avatar,fit: BoxFit.cover,),
        );
      }

  }
}
