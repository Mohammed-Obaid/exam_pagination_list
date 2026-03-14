import 'app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  // App bar greeting
  static const TextStyle greeting = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: AppColors.textPrimary,
  );

  // Card - Booking ID (image: 16–18px, regular, dark gray)
  static const TextStyle cardTitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.titleColor,
  );

  // Card - date/time line (green, 14–16px)
  static const TextStyle dateTime = TextStyle(
    fontSize: 16,
    color: AppColors.dateTimeGreen,
    fontWeight: FontWeight.w500,
  );

  // Card - body labels (image: 16px, dark gray)
  static const TextStyle label = TextStyle(
    fontSize: 16,
    color: AppColors.textBody,
  );

  // Card - price/cost value (green, bold)
  static const TextStyle priceValue = TextStyle(
    fontSize: 16,
    color: AppColors.primaryGreen,
    fontWeight: FontWeight.bold,
  );

  // Location (blue, underlined, 14–16px)
  static const TextStyle location = TextStyle(
    fontSize: 16,
    color: AppColors.locationBlue,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.locationBlue,
  );

  // Status chip (size/weight; color comes from AppColors per status)
  static const TextStyle chip = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  // Accept button (image: dark green text on light green bg)
  static const TextStyle primaryAction = TextStyle(
    color: AppColors.acceptButtonFg,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  // Reject button (image: dark red text on light red bg)
  static const TextStyle destructiveAction = TextStyle(
    color: AppColors.rejectButtonFg,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
