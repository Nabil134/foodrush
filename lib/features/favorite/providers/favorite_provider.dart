import 'package:flutter/material.dart';
import '../../category/models/category_model.dart';
class FavoriteProvider extends ChangeNotifier{
  final List<Items> _favItems=[];
  List<Items> get favItems=>_favItems;
  bool isFavorite(Items item)=>_favItems.any((favorite) => favorite.name==item.name);
  /* toggleFavorite*/
  void toggleFavorite(Items item){
    if(isFavorite(item)){
      _favItems.removeWhere((favorite) => favorite.name==item.name);
    }
    else{
      _favItems.add(item);
    }
    notifyListeners();
  }
/* toggleFavorite*/
 

}