import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if(kDebugMode){
      debugPrint("➡️ Request");
      debugPrint("Method:${options.method}");
      debugPrint("URL:${options.uri}");
      debugPrint("Header:${options.headers}");
      debugPrint("Data:${options.data}");
    }
    handler.next(options);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(kDebugMode){
      debugPrint("✅ Response");
      debugPrint("Status Code:${response.statusCode}");
      debugPrint(response.data.toString(),);
    }
    handler.next(response);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if(kDebugMode){
      debugPrint("❌ Error");
      debugPrint(err.message);
      debugPrint(err.response?.data.toString(),);
    }
    handler.next(err);
  }
}