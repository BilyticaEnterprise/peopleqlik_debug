abstract class AppState
{

}

class AppStateStart extends AppState
{
}

class AppStateDone<T> extends AppState
{
  T? data;
  AppStateDone({this.data});
}

class AppStateError<T> extends AppState
{
  T? data;
  AppStateError({this.data});
}

class AppStateEmpty<T> extends AppState
{
  T? data;
  AppStateEmpty({this.data});
}

class AppStateNothing extends AppState
{

}
