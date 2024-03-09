import 'package:dio/dio.dart';

class DioSetUp
{
  Dio getDio({String? cookieToken})
  {
    Dio dio = Dio();
    if(cookieToken!=null)
      {
        dio.interceptors.add(
            InterceptorsWrapper(
                onRequest:(options, handler) async {
                  // to prevent other request enter this interceptor.
                  options.headers['Cookie'] = 'XRF_TOKEN=$cookieToken';
                  // options.headers['XRF_TOKEN'] = cookieToken;
                  // We use a new Dio(to avoid dead lock) instance to request token.
                  //Set the cookie to headers
                  // options.headers["cookie"] = aToken;
                  // XRF_TOKEN
                  return handler.next(options); //continue
                }
            ));
      }

    return dio;
  }
}