import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_rush/core/routes/route_names.dart';
import 'package:food_rush/features/main/presentations/main_screen.dart';
import 'package:food_rush/features/splash/presentations/splash_screen.dart';

class AppRoutes{
  AppRoutes._();
  /*generateRoute start here*/
static Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case RouteNames.splash:
      return MaterialPageRoute(builder: (context) => const SplashScreen(),);
    case RouteNames.main:
      return MaterialPageRoute(builder: (context) => const MainScreen(),);
    default:
      return MaterialPageRoute(builder: (context) => Scaffold(body: Center(child: const Text("No Route Found"),),),);
  }

}
/*generateRoute end here*/
}