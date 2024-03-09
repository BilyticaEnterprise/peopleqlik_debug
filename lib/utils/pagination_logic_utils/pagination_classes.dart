import 'package:flutter/cupertino.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

// mixin PaginationClasses
// {
//
//   start(BuildContext context,ApiStatus status);
//   updateStep(bool event,BuildContext context);
//   updatedResponseAtReachedEndList();
//   reachedEndList(bool reached);
// }

mixin GetPaginationClasses<T>
{

  bool reachedEnd = false;
  int page = 0;
  List<T>? dataList;
  late T type;

  passInitialData();
  start(BuildContext context,ApiStatus status);
  reachedEndList(bool reached);

  receiveInitialData(List<T>? dataList,T type)
  {
    this.dataList = dataList;
    this.type = type;
  }

  updateStep(bool event,BuildContext context){
    if(reachedEnd==false&&event==true)
    {
      dataList?.add(type);
      reachedEndList(true);
      start(context,ApiStatus.pagination);
    }
  }
  updatedResponseAtReachedEndList(ApiStatus apiStatus){
    int? length = dataList?.length;
    if(apiStatus==ApiStatus.pagination&&length!=null&&length>0)
    {
      dataList?.removeAt(length-1);
    }
    reachedEndPage(false);
  }
  makeListNull()
  {
    dataList = null;
    decrementPage();
  }
  resetList()
  {
    reachedEndPage(false);
    page = 1 ;
    dataList?.clear();
  }
  clearList()
  {
    dataList?.clear();
  }

  addAllList(List<T> list)
  {
    dataList?.addAll(list);
  }

  reachedEndPage(bool reached)
  {
    reachedEnd = reached;
  }

  resetPageCounter()
  {
    page = 1;
  }

  incrementPage()
  {
    page += 1;
  }

  decrementPage()
  {
    page -= 1;
  }
}
