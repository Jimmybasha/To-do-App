import 'package:flutter/material.dart';
import 'package:todoapp/Style/AppColors.dart';

class AppStyle{

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackGroundColor,
    textTheme: const TextTheme(
      labelSmall: TextStyle(
        fontSize: 12,
        color: AppColors.labelColor,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white
      )
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.lightPrimaryColor,
        primary: AppColors.lightPrimaryColor,
    )
  );

}