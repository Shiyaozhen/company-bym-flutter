import 'package:BYM/generated/l10n.dart';
import 'package:BYM/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Flutter Luckin Coffee',
    initialRoute: '/Home',
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
            TextStyle( color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold), // 文字加粗
          ),
        ),
      ),
      //文本样式
      textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF383838),
          ),
          headline2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF383838)),
          headline3: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF383838)),
          headline4: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF383838)),
          headline5: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF383838)),
          headline6: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF383838))),
    ),
  ));
}
