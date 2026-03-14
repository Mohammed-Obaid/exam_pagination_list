import 'app_colors.dart';
import 'app_radii.dart';
import 'app_spacing.dart';
import 'package:flutter/material.dart';

class AppButtonStyles {
  static const double _buttonHeight = 48;

  /// Accept: light green bg, dark green text/border, pill (match design image)
  static final ButtonStyle acceptOutlined = OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.buttonVertical),
    minimumSize: const Size(0, _buttonHeight),
    backgroundColor: AppColors.acceptButtonBg,
    foregroundColor: AppColors.acceptButtonFg,
    side: const BorderSide(color: AppColors.acceptButtonFg, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.button),
    ),
  );

  /// Reject: light red bg, dark red text/border, pill (match design image)
  static final ButtonStyle rejectOutlined = OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.buttonVertical),
    minimumSize: const Size(0, _buttonHeight),
    backgroundColor: AppColors.rejectButtonBg,
    foregroundColor: AppColors.rejectButtonFg,
    side: const BorderSide(color: AppColors.rejectButtonFg, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.button),
    ),
  );
}
