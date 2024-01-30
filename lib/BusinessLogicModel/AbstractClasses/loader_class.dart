import 'dart:async';

import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/src/loader.dart';


mixin GetLoader
{
  StreamController<bool>? loadingStream;
  bool started = false;
  void initLoader()
  {
    loadingStream = StreamController.broadcast();
    started = true;
    ShowLoaderPopUp.showExtraNow(GetNavigatorStateContext.navigatorKey.currentContext!,loadingStream!,
            (){
              started = false;
            }
    );
  }
  
  Future? check()async
  {
    if(started == false)
      {
        await Future.delayed(const Duration(milliseconds: 20));
        return true;
      }
    else
      {
        await Future.delayed(const Duration(milliseconds: 20));
        check();
      }
  }

  closeLoader()async
  {
    if(loadingStream!=null&&loadingStream!.isClosed==false)
      {
        loadingStream?.add(true);
      }
    return await check();
  }

  disposeLoader()
  {
    loadingStream?.close();
  }
}