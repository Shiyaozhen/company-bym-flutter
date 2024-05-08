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
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      S.delegate
    ],
    supportedLocales: [const Locale('zh', ''), ...S.delegate.supportedLocales],
  ));
}
