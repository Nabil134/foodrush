
import 'package:flutter/material.dart';
import 'package:food_rush/core/constant/app_images.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/app_colors.dart';
import '../providers/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashProvider>().navigateToMain(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary1,
              AppColors.primary,
            ],
          ),
        ),
        child: Stack(
          children: [


            Align(
              alignment: const Alignment(0,-0.30),
              child: Image.asset(AppImages.logo),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                AppImages.splash1,
                width: 170,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Image.asset(
                  AppImages.splash2,
                  width: 160,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}