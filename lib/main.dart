import 'package:BYM/generated/l10n.dart';
import 'package:BYM/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Flutter Luckin Coffee',
    initialRoute: '/Login',
    getPages: pages,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      S.delegate,
    ],
    supportedLocales: [
      const Locale('zh', ''),
      ...S.delegate.supportedLocales,
    ],
    theme: ThemeData(
      //按钮
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor:
              MaterialStateProperty.all<Color>(Color(0xFF5475F8)), // 背景色
          minimumSize: MaterialStateProperty.all<Size>(Size(350, 50)),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold), // 文字加粗
          ),
        ),
      ),
      //文字
      textTheme: TextTheme(
          displaySmall: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF383838),
          ),
          displayMedium: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF383838)),
          displayLarge: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF383838)),
          headlineSmall: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF383838)),
          headlineMedium: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF383838)),
          headlineLarge: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF383838))),
      //输入框
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFF5F7FF),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
        //请输入内容
        hintStyle: TextStyle(color: Color(0xFF7989B2), fontSize: 16),
      ),
      //输入光标颜色
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Color(0xFF5475F8),
      ),
    ),
  ));
}
