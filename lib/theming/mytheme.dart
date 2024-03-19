
import 'package:flutter/material.dart';

class MyTheme{

  static var colorPrimary=Color(0xff5D9CEC);
  static var colorOnPrimary=Color(0xffDFECDB);
  static var colorGreen=Color(0xff61E757);
  static var deleteColor=Color(0xffFE4A49);


  static var colorPrimaryDark=Color(0xff24252D);
  static var colorOnPrimaryDark=Color(0xff525668);
  static var colorPurble=Color(0xff8964EA);
  static var colorOrange=Color(0xffF98824);

  static ThemeData lightMode=ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: MyTheme.colorPrimary,
        ),
    textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 23),
     bodySmall: TextStyle(color: Color(0xffCACACA),fontSize: 16,fontWeight: FontWeight.w600),


    )

  );

  static ThemeData darktMode=ThemeData(
      appBarTheme: AppBarTheme(backgroundColor:Colors.black,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: MyTheme.colorPurble),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(colorPurble),)),
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.black,shadowColor: Colors.black12,),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: MyTheme.colorPurble,unselectedItemColor: Colors.white),
      textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 23),
        bodySmall: TextStyle(color: Color(0xffCACACA),fontSize: 16,fontWeight: FontWeight.w600))

  );
}