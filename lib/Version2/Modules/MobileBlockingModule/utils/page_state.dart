abstract class MobileBlocPageState
{

}

class PageStateRegister<T> extends MobileBlocPageState
{
  T? data;
  PageStateRegister({this.data});
}

class PageStateNotRegister<T> extends MobileBlocPageState
{
  T? data;
  PageStateNotRegister({this.data});
}

class PageStateDeactivateRegister<T> extends MobileBlocPageState
{
  T? data;
  PageStateDeactivateRegister({this.data});
}