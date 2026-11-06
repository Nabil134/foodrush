import 'package:flutter/material.dart';
import 'package:food_rush/features/cart/presentations/cart_screen.dart';
import 'package:food_rush/features/favorite/presentations/favorite_screen.dart';
import 'package:food_rush/features/home/presentations/home_screen.dart';
import 'package:food_rush/features/profile/presentations/profile_screen.dart';
class MainProvider with ChangeNotifier{
int _currentIndex=0;
int get currentIndex=>_currentIndex;
/*changeIndex start here*/
void changeIndex(int index){
  _currentIndex=index;
  notifyListeners();
}
/*changeIndex end here*/
/*pages start here*/
  final List<Widget> pages=[
    HomeScreen(),
    ProfileScreen(),
    CartScreen(),
    FavoriteScreen(),

  ];
/*pages end here*/
}