// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// ``
  String get email {
    return Intl.message(
      '',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get email_hint {
    return Intl.message(
      '',
      name: 'email_hint',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get password {
    return Intl.message(
      '',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get password_hint {
    return Intl.message(
      '',
      name: 'password_hint',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get register {
    return Intl.message(
      '',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get forget_password {
    return Intl.message(
      '',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get read_and_agree {
    return Intl.message(
      '',
      name: 'read_and_agree',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get privacy {
    return Intl.message(
      '',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get login {
    return Intl.message(
      '',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get experience_power_station {
    return Intl.message(
      '',
      name: 'experience_power_station',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get current_power {
    return Intl.message(
      '',
      name: 'current_power',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get installed_capacity {
    return Intl.message(
      '',
      name: 'installed_capacity',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get current_power_generation {
    return Intl.message(
      '',
      name: 'current_power_generation',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get power_generation_for_the_current_month {
    return Intl.message(
      '',
      name: 'power_generation_for_the_current_month',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get cumulative_power_generation {
    return Intl.message(
      '',
      name: 'cumulative_power_generation',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get online_equipment {
    return Intl.message(
      '',
      name: 'online_equipment',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get offline_equipment {
    return Intl.message(
      '',
      name: 'offline_equipment',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get abnormal_equipment {
    return Intl.message(
      '',
      name: 'abnormal_equipment',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get power_generation_statistics {
    return Intl.message(
      '',
      name: 'power_generation_statistics',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get day {
    return Intl.message(
      '',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get month {
    return Intl.message(
      '',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get year {
    return Intl.message(
      '',
      name: 'year',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
