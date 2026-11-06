import 'dart:convert';

import 'package:food_rush/core/network/network_api_service.dart';
import 'package:food_rush/features/category/models/category_model.dart';

import '../../../core/network/api_endponts.dart';

class CategoryService{
  final NetworkApiService _apiService;
  CategoryService():_apiService=NetworkApiService();
/*getCategory start here*/
Future<CategoryModel?> getCategory(String category) async {
  final response= await _apiService.get(ApiEndPoints.products,null);
dynamic data=response;
if(data is String){
  data = jsonDecode(data);
}
final categories= (data as List).map((item) => CategoryModel.fromJson(Map<String,dynamic>.from(item))).toList();
for(final item in categories){
  if(item.category==category){
    return item;
  }
}
return null;
}
/*getCategory end here*/
}