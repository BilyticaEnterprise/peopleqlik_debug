abstract class MobileBlocPageState
{

}

class MobilePageStateFirstRegister<T> extends MobileBlocPageState
{
  T? data;
  MobilePageStateFirstRegister({this.data});
}

class MobilePageStateNotRegister<T> extends MobileBlocPageState
{
  T? data;
  MobilePageStateNotRegister({this.data});
}

class MobilePageStateAutoApproveDeactivateAndRegister<T> extends MobileBlocPageState
{
  T? data;
  MobilePageStateAutoApproveDeactivateAndRegister({this.data});
}

class MobilePageStateLimitReached<T> extends MobileBlocPageState
{
  T? data;
  MobilePageStateLimitReached({this.data});
}

class MobilePageStateAskAdminToApprove<T> extends MobileBlocPageState
{
  T? data;
  MobilePageStateAskAdminToApprove({this.data});
}

class MobilePageStateMobileBlocked<T> extends MobileBlocPageState
{
  T? data;
  MobilePageStateMobileBlocked({this.data});
}