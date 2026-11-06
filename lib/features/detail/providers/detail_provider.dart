import 'package:flutter/material.dart';
import 'package:food_rush/features/category/models/category_model.dart';
class DetailProvider with ChangeNotifier{
  final Items items;
  DetailProvider({required this.items});
double _spicyLevel=0.25;
double get spicyLevel=>_spicyLevel;
int _quantity = 1;
int get quantity=>_quantity;
/*increaseQty start here*/
  void increaseQty(){
    _quantity++;
    notifyListeners();
  }
  /*increaseQty end here*/
  /*increaseQty start here*/
  void decreaseQty(){
    if(_quantity>1){
      _quantity--;
    }
    notifyListeners();
  }
  /*increaseQty end here*/
/*changeSpicyLevel start here*/
void  changeSpicyLevel(double value){
_spicyLevel=value;
notifyListeners();
}
/*changeSpicyLevel end here*/
/*spicyText start here*/
String get spicyText{
  if(_spicyLevel<=0.25){
    return "Mild";
  }
  else if(_spicyLevel<=0.5){
    return "Medium";
  }
  else if(_spicyLevel<=0.5){
    return "Hot";
  }
  else{
    return 'Very Hot';
  }
}
/*spicyText end here*/
/*unitPrice start here*/
double get unitPrice{
  return (items.price??0).toDouble();
}
/*unitPrice send here*/
/* totalPrice start here*/
  double get totalPrice{
    return unitPrice*_quantity;
  }
/* totalPrice send here*/
}