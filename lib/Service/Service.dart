import 'package:http/http.dart' as Http;
// import 'package:http_interceptor/http_interceptor.dart';

// class LoggingInterceptor implements InterceptorContract {
//   @override
//   Future<RequestData> interceptRequest({required RequestData data}) async {
//     print(data.toString());
//     try {
//       data.params['appid'] = 'OPEN_WEATHER_API_KEY';
//       data.params['units'] = 'metric';
//       data.headers["Content-Type"] = "application/json";
//     } catch (e) {
//       print(e);
//     }
//     return data;
//   }
//
//   @override
//   Future<ResponseData> interceptResponse({required ResponseData data}) async {
//     print(data.toString());
//     return data;
//   }
// }