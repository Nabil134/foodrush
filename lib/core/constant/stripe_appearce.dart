import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_rush/core/constant/app_colors.dart';

class StripeAppearance {
  StripeAppearance._();
  /*foodRush start here*/
  static PaymentSheetAppearance get foodRush {
    return PaymentSheetAppearance(
      colors: PaymentSheetAppearanceColors(
        background: Colors.white,
        primary: AppColors.primary,
        componentBackground: const Color(0xFFF5F5F5),
        componentBorder: Colors.transparent,
        componentDivider: const Color(0xFFE0E0E0),
        primaryText: const Color(0xFF1C1C1C),
        secondaryText: const Color(0xFF6A6A6A),
        componentText:  Colors.black,
        placeholderText: const Color(0xFF9E9E9E),
        icon: AppColors.black,
        error: Colors.red,
      ),
      shapes: PaymentSheetShape(
        borderRadius: 16,
        borderWidth: 1,
      ),
      primaryButton: PaymentSheetPrimaryButtonAppearance(
        colors: PaymentSheetPrimaryButtonTheme(
          light: PaymentSheetPrimaryButtonThemeColors(
            background: const Color(0xFF1C1C1C),
            text: Colors.white,
            border: Colors.transparent,
          ),
        ),
      ),
    );
  }
/*foodRush end here*/
}