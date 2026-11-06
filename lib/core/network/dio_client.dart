import 'package:dio/dio.dart';
import 'package:food_rush/core/network/dio_interceptor.dart';
import 'api_endponts.dart';
class DioClient{
  late final Dio dio;
  DioClient(){
    dio=Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    )..interceptors.add(DioInterceptor(),);
  }
}