import 'package:dio/dio.dart';

import '../../../src/prints_logs.dart';

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
    // (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //
    //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //   //
    //   // SecurityContext sc = SecurityContext(withTrustedRoots: false);
    //   // sc.setTrustedCertificatesBytes(LoadCertificates.sslCert1.buffer.asInt8List());
    //   // //sc.setTrustedCertificatesBytes(LoadCertificates.sslCert2.buffer.asInt8List());
    //   // // sc.setTrustedCertificatesBytes(LoadCertificates.sslCert3.buffer.asInt8List());
    //   // //context.setTrustedCertificates(null);
    //   //
    //   // // context.setTrustedCertificatesBytes(
    //   // // rootCACertificate.buffer.asUint8List());
    //   // //
    //   // // context
    //   // //     .useCertificateChainBytes(clientCertificate.buffer.asUint8List());
    //   // //
    //   // // context.usePrivateKeyBytes(privateKey.buffer.asUint8List());
    //   //
    //   //
    //   //
    //   //   HttpClient httpClient = HttpClient(context: sc);
    //   // httpClient.badCertificateCallback =
    //   //     (X509Certificate cert, String host, int port) => true;
    //   //
    //   return client;
    // };
    return dio;
  }
}