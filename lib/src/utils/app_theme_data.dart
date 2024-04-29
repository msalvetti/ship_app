import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ship_app/src/constants/app_colors.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';

/// Custom theming for the app, based on FlexColorScheme.
/// For more details, see: https://docs.flexcolorscheme.com/
extension AppThemeData on ThemeData {
  static ThemeData light() =>
      FlexThemeData.light(scheme: AppColors.flexScheme)._customAppTheme();
  static ThemeData dark() =>
      FlexThemeData.dark(scheme: AppColors.flexScheme)._customAppTheme();

  ThemeData _customAppTheme() {
    // An updated theme with bigger text sizes
    return copyWith(
      textTheme: TextTheme(
        titleLarge: textTheme.titleLarge?.copyWith(fontSize: 22.0),
        titleMedium: textTheme.titleMedium?.copyWith(fontSize: 18.0),
        titleSmall: textTheme.titleMedium?.copyWith(fontSize: 14.0),
        bodyLarge: textTheme.bodyLarge?.copyWith(fontSize: 20.0),
        bodyMedium: textTheme.bodyMedium?.copyWith(fontSize: 18.0),
        bodySmall: textTheme.bodySmall?.copyWith(fontSize: 14.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(Sizes.p8),
          textStyle:
              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}