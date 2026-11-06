import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_rush/core/routes/route_names.dart';
import 'package:food_rush/features/category/providers/category_provider.dart';
import 'package:food_rush/features/favorite/providers/favorite_provider.dart';
import 'package:food_rush/features/home/providers/home_provider.dart';
import 'package:food_rush/features/main/providers/main_provider.dart';
import 'package:food_rush/features/splash/providers/splash_provider.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/cart/providers/cart_provider.dart';
import 'features/payment/providers/payment_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  Stripe.publishableKey =
      dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';

  await Stripe.instance.applySettings();
  runApp(
    MultiProvider(providers:[
      ChangeNotifierProvider(create: (context) => SplashProvider(),),
      ChangeNotifierProvider(create: (context) => MainProvider(),),
      ChangeNotifierProvider(create: (context) => HomeProvider(),),
      ChangeNotifierProvider(create: (context) => CategoryProvider(),),
      ChangeNotifierProvider(create: (context) => CartProvider(),),
     ChangeNotifierProvider(create: (context) => FavoriteProvider(),),
    ],child: MyApp(),),);
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      themeMode: ThemeMode.light,
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

