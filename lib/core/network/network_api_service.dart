import 'package:dio/dio.dart';
import 'package:food_rush/core/network/dio_client.dart';
import 'package:food_rush/core/network/errors/api_exception.dart';
import 'package:food_rush/core/network/network_info.dart';
import 'base_api_service.dart';
class NetworkApiService implements BaseApiService{
  late final Dio _dio;
  NetworkApiService(){
    _dio = DioClient().dio;
  }
  @override
  Future<dynamic> get(String endpoint, Map<String, dynamic>? queryParameters) async {
    if(!NetworkInfo.isConnected){
throw Exception("No Internet Connection");
    }
    try{
final response= await  _dio.get(endpoint,queryParameters: queryParameters,);
return response.data;
    }
    on DioException catch(e){
      throw Exception(ApiException.getMessage(e),);
    }
  }
}