import 'package:logger/logger.dart';

class BYLog{

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
  ),
  );

  static bool _debugMode = false;

  BYLog(bool valueFromChild);

  static void init(bool bool, { bool isDebug = false}) {
    _debugMode = isDebug;
  }

  static void e(Object object) {
    _logger.e(object);
  }

  static void d(Object object) {
    if (_debugMode) {
      _logger.d(object);
    }
  }

  static void i(Object object) {
    _logger.i(object);
  }

  static void w(Object object) {
    _logger.w(object);
  }





}