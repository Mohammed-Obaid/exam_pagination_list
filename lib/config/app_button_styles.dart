import 'app_radii.dart';
import 'app_spacing.dart';
import 'package:flutter/material.dart';

class AppButtonStyles {
  static final ButtonStyle acceptOutlined = OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.buttonVertical),
    backgroundColor: const Color(0xFFE0F4EA), // soft green fill
    foregroundColor: Colors.green,
    side: const BorderSide(color: Colors.green, width: 1.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.button),
    ),
  );

  static final ButtonStyle rejectOutlined = OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.buttonVertical),
    backgroundColor: const Color(0xFFFDE8E8), // soft red fill
    foregroundColor: Colors.red,
    side: const BorderSide(color: Colors.red, width: 1.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.button),
    ),
  );
}
