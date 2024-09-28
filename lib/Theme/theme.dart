
import 'package:flutter/material.dart';

class MyThemeData{
//--------------------------
static  const Color primaryColor=Color(0xff121312);
static  const Color onPrimaryColor=Color(0xff343534);
static const Color  fadePrimaryColor=Color(0xffC6C6C6);
static const Color  darkPrimaryColor=Color(0xff1A1A1A);
//--------------------------
static  const Color secondaryColor=Color(0xffF7B539);
static  const Color onSecondaryColor=Color(0xffFFFFFF);



  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: const Color(0xff121312),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: MyThemeData.secondaryColor,
      unselectedItemColor: MyThemeData.fadePrimaryColor,
      backgroundColor: MyThemeData.darkPrimaryColor,



      selectedLabelStyle: TextStyle(
        color: MyThemeData.onSecondaryColor,
        fontSize: 8,
      )

    ),
    iconTheme: const IconThemeData(color: MyThemeData.onSecondaryColor),


    textTheme: const TextTheme(
    titleSmall: TextStyle(
      color: MyThemeData.onSecondaryColor,
      fontSize: 8,
    ),

    titleMedium: TextStyle(
      color: MyThemeData.onSecondaryColor,
      fontSize: 16,

    ),
     titleLarge: TextStyle(
       color: MyThemeData.onSecondaryColor,
       fontSize: 22,
     ),

     bodySmall: TextStyle(
       color: MyThemeData.onSecondaryColor,
       fontSize: 14,
     ),


    ),




      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        secondary:secondaryColor ,
        onSecondary: onSecondaryColor,
        surface: darkPrimaryColor,
      ),


  );




}