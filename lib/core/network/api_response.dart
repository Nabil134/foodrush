import 'package:food_rush/core/network/api_status.dart';
class  ApiResponse<T>{
final Status status;
final T? data;
final String? message;
const ApiResponse.idle():status=Status.idle, data=null, message=null;
const ApiResponse.loading():status=Status.loading, data=null, message=null;
const ApiResponse.completed(this.data):status=Status.completed, message=null;
const ApiResponse.error(this.message):status=Status.error, data=null;
@override
  String toString() {
  return '''
    Status:$status
    Data:$data
    Message:$message
    ''';
  }
}