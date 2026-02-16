import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppGradients {
  /// Alarm screen background gradient (yellow → orange)
  static const LinearGradient alarmBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
  );

  /// Premium card gradient for paywall price card
  static const LinearGradient premiumCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
  );
}
