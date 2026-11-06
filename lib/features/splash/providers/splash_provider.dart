import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_rush/core/routes/route_names.dart';

class SplashProvider extends ChangeNotifier {

  Future<void> navigateToMain(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    if (!context.mounted) return;

    Navigator.pushReplacementNamed(context, RouteNames.main);
  }
}