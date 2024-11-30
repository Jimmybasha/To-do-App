import 'package:flutter/material.dart';
import 'package:todoapp/Style/AppColors.dart';

class AppStyle{

  static ThemeData lightTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 3,

        )
      )
    ),
    appBarTheme:const AppBarTheme(
      backgroundColor: AppColors.lightPrimaryColor,
      toolbarHeight: 157,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.white
      )
    ) ,
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
      titleMedium:TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.lightPrimaryColor
      ) ,
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white
      )
    ),
    iconTheme:const  IconThemeData(
      color: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.lightPrimaryColor,
        primary: AppColors.lightPrimaryColor,
    ),
    useMaterial3: false,


  );

}