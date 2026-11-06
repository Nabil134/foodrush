import 'package:flutter/material.dart';
import 'package:food_rush/features/category/services/category_service.dart';
import '../../../core/network/api_response.dart';
import '../models/category_model.dart';
class CategoryProvider with ChangeNotifier{
CategoryService categoryService= CategoryService();
ApiResponse<CategoryModel> _categoryResponse= const ApiResponse.idle();
ApiResponse<CategoryModel> get categoryResponse=>_categoryResponse;
List<Items> _filteredList=[];
List<Items> get filteredList=>_filteredList;
final TextEditingController searchController= TextEditingController();
/*getCategory start here*/
 Future<void> getCategory(String category) async {
    _categoryResponse= const ApiResponse.loading();
    searchController.clear();
    notifyListeners();
    try{
      final response=  await categoryService.getCategory(category);
      if(response==null){
_categoryResponse=const ApiResponse.error("Category Not Found");
_filteredList=[];
      }
      else{
_categoryResponse=ApiResponse.completed(response);
_filteredList= response.items??[];

      }
    }
     catch(e){
       _categoryResponse=  ApiResponse.error(e.toString(),);
       _filteredList=[];
     }
     notifyListeners();
 }
/*getCategory end here*/
/*searchProducts start here*/
  void searchProducts(String query){
    final category=_categoryResponse.data;
    if(category==null || category.items==null){
return;
    }
    if(query.trim().isEmpty){
_filteredList=category.items!;
    }
    else{
final searchQuery=query.toLowerCase().trim();
_filteredList=category.items!.where((item){
final name=item.name?.toLowerCase()??"";
return name.contains(searchQuery);
}).toList();
    }
    notifyListeners();
  }
  /*searchProducts end here*/
  /*clearSearch start here*/
  void clearSearch(){
    searchController.clear();
    final  category= _categoryResponse.data;
   if(category!=null){
     _filteredList= category.items??[];
   }
    notifyListeners();

  }
  /*clearSearch end here*/
@override
  void dispose() {
  searchController.dispose();
    super.dispose();
  }
}