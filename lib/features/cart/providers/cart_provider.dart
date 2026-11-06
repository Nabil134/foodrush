import 'package:flutter/material.dart';

import '../../category/models/category_model.dart';

class CartProvider with ChangeNotifier{
/*toppings start here*/
final List<Map<String , String>> toppings=[
  {'name': 'Tomato', 'image': 'https://images.unsplash.com/photo-1558818498-28c1e002b655?w=200'},
  {'name': 'Onions', 'image': 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=200'},
  {'name': 'Pickles', 'image': 'https://images.unsplash.com/photo-1590060580750-02a3a1d8d9b5?w=200'},
  {'name': 'Bacons', 'image': 'https://images.unsplash.com/photo-1528607929212-2636ec44253e?w=200'},
  {'name': 'Cheese', 'image': 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=200'},
];
/*toppings end here*/
  /*sideOptions start here*/
  final List<Map<String, String>> sideOptions = [
    {'name': 'Fries', 'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/McDonald%27s_French_Fries.jpg/320px-McDonald%27s_French_Fries.jpg'},
    {'name': 'Coleslaw', 'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Coleslaw.jpg/320px-Coleslaw.jpg'},
    {'name': 'Salad', 'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/Salad_garden.jpg/320px-Salad_garden.jpg'},
    {'name': 'Onion', 'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Lyonnaise_salad.jpg/320px-Lyonnaise_salad.jpg'},
  ];
  /*sideOptions end here*/
final List<Items> _items=[];
  List<Items> get items=>List.unmodifiable(_items);
  static const double _deliveryFee = 2.0;
  double get deliverFee=>_items.isEmpty?0:_deliveryFee;
  bool get isEmpty=>_items.isEmpty;
 int get totalCount=>_items.fold<int>(0, (sum, item) => sum+item.qty);
  double get subTotal=>_items.fold<double>(0.0, (sum, item) => sum+(item.qty*(item.price??0.0)),);
/* totalPrice start here */
double get totalPrice=> subTotal+ deliverFee+taxes;
/* totalPrice end here */
/*addItem start here*/
void addItem(Items item,{required int qty}){
final index= _items.indexWhere((i) =>i.name==item.name);
if(index!=-1){
_items[index].qty+=qty;
}
else{
  _items.add(Items(name:item.name, description: item.description, image: item.image, price: item.price, qty: qty,),);
}
notifyListeners();
}
/*addItem end here*/
/*increaseQty start here*/
void increaseQty(Items items){
items.qty++;
notifyListeners();
}
/*increaseQty end here*/
/*decreaseQty start here*/
  void decreaseQty(Items items){
    if(items.qty>1){
      items.qty--;
      notifyListeners();
    }
  }
/*decreaseQty end here*/
/*removeItem start here*/
void removeItem(Items items){
_items.remove(items);
notifyListeners();
}
/*removeItem end here*/
  static const double _taxRate = 0.018;
  double get taxes=>subTotal*_taxRate;
  /* clearCart start here */
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
/* clearCart end here */
}
