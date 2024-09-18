import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class ShowTransparentLoaderPopUp
{

  static showTransparent(BuildContext context, StreamController<bool> loadingStream, Function() callBack)
  {
    showDialog(context: context,barrierColor: const Color(MyColor.colorBlack).withOpacity(0.0),builder: (BuildContext dialogContext)=> TransparentLoaderPopUp(dialogContext,loadingStream: loadingStream,)).then((value){
      callBack();
    });
  }
}
class TransparentLoaderPopUp extends StatefulWidget {
  BuildContext dialogContext;
  StreamController<bool>? loadingStream;
  TransparentLoaderPopUp(this.dialogContext,{Key? key, this.loadingStream}) : super(key: key);

  @override
  _TransparentLoaderPopUpState createState() => _TransparentLoaderPopUpState();
}

class _TransparentLoaderPopUpState extends State<TransparentLoaderPopUp> with TickerProviderStateMixin{

  dynamic animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.loadingStream!.isClosed==false)
    {
      widget.loadingStream!.stream.listen((event) {
        // print('listenedddddd');
        try{
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if(Navigator.canPop(context))
            {
              Navigator.pop(context);
            }
          });
        }catch(e){
          // print('comed ${e.toString()}');
        }
      });
    }
    else
    {
      print('not listenedddddd');

    }

    return Material(
      color: const Color(MyColor.colorTransparent),
      child: SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: LayoutBuilder(
          builder: (context,constraints)
          {
            return SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Container(height: 0,)
            );
          },
        ),
      ),
    );
  }
}