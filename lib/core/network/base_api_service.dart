abstract class BaseApiService{
Future<dynamic> get(String endpoint,Map<String,dynamic>? queryParameters);
}