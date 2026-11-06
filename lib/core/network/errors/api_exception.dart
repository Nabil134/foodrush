import 'package:dio/dio.dart';
class ApiException{
  ApiException._();
/*getMessage start here*/
static String  getMessage(DioException exception){
  switch(exception.type){
    case DioExceptionType.connectionTimeout:
      return "Connection Timeout";
    case DioExceptionType.sendTimeout:
      return "Request Timeout";
    case DioExceptionType.receiveTimeout:
      return "Receive Timeout";
    case DioExceptionType.connectionError:
      return "No Internet Connection";
    case DioExceptionType.badCertificate:
      return "Bad Certificate";
    case DioExceptionType.cancel:
      return "Request Cancel";
    case DioExceptionType.badResponse:
      return handleStatusCode(exception.response);
    case DioExceptionType.unknown:
    default:
      return "Something went wrong";
  }
}
/*getMessage end here*/
/*handleStatusCode start here*/
static String handleStatusCode(Response? response){
  switch(response?.statusCode){
    case 400:
      return response?.data["message"]??"Bad Request";
    case 401:
      return response?.data["message"]??"Unauthorized";
    case 403:
      return response?.data["message"]??"Forbidden";
    case 404:
      return response?.data["message"]??"Not Found";
    case 405:
      return response?.data["message"]??"Method Not Found";
    case 408:
      return response?.data["message"]??"Request Timeout";
    case 409:
      return response?.data["message"]??"Conflict";
    case 422:
      return response?.data["message"]??"Validation Error";
    case 429:
      return response?.data["message"]??"Too Many Requests";
    case 500:
      return response?.data["message"]??"Internal Server Error";
    case 501:
      return response?.data["message"]??"Not Implemented";
    case 502:
      return response?.data["message"]??"Bad Gateway";
    case 503:
      return response?.data["message"]??"Server Unavailable";
    case 504:
      return response?.data["message"]??"Gateway Timeout";
    default:
      return response?.data["message"]??"UnExpected Error";
  }
}
/*handleStatusCode end here*/
}