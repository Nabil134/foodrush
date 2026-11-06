import 'package:flutter/material.dart';
import 'package:food_rush/features/category/providers/category_provider.dart';
class HomeProvider extends ChangeNotifier{

late TabController tabController;
int _tabIndex=0;

int get tabIndex=>_tabIndex;
/*categories start here*/
  final List<String> categories=[
    "burgers",
    'desserts',
    'chinese',
  ];
/*categories end here*/
  /*initializeTabController start here*/
  void initializeTabController(TickerProvider vsync,CategoryProvider categoryProvider){
    tabController= TabController(
      length: categories.length,
      vsync: vsync,
    );
    tabController.addListener(() {
      if(_tabIndex!=tabController.index){
        _tabIndex=tabController.index;
        notifyListeners();
categoryProvider.getCategory(categories[_tabIndex]);
      }
    });
  }
  /*initializeTabController end here*/
  /*_onTapChange start here*/
  void _onTapChange(){
    if(_tabIndex!=tabController.index){
      _tabIndex=tabController.index;
      notifyListeners();
    }
  }
  /*_onTapChange end here*/
  /*disposeTabController start here*/
  void disposeTabController(){
    tabController.removeListener(_onTapChange);
    tabController.dispose();
  }
  /*disposeTabController end here*/
@override
  void dispose() {
  tabController.removeListener(_onTapChange);
    tabController.dispose();
    super.dispose();
  }
}