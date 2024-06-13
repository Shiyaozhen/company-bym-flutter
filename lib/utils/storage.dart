import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  // 这个类里有工厂构造函数、私有构造函数、getter和私有静态实例
  // 向外暴露的只有工厂构造函数和getter
  // 调用工厂构造函数和getter获取的都是这个私有静态实例
  // 这个私有静态实例只能通过私有构造函数初始化
  // 因此这个类只向外暴露唯一的一个实例，即单例
  Storage._internal();
  static final Storage _instance = Storage._internal();
  factory Storage() => _instance;
  static Storage? get instance => _instance;


  SharedPreferences? _prefs;

  // 初始化 SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 获取整数值
  int getInt(String key, [int defaultValue = 0]) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  // 设置整数值
  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  // 获取字符串值
  String getString(String key, [String defaultValue = '']) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  // 设置字符串值
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // 获取布尔值
  bool getBool(String key, [bool defaultValue = false]) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  // 设置布尔值
  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  // 获取双精度浮点数值
  double getDouble(String key, [double defaultValue = 0.0]) {
    return _prefs?.getDouble(key) ?? defaultValue;
  }

  // 设置双精度浮点数值
  Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  // 获取字符串列表
  List<String> getStringList(String key, [List<String> defaultValue = const []]) {
    return _prefs?.getStringList(key) ?? defaultValue;
  }

  // 设置字符串列表
  Future<void> setStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value);
  }

  // 移除某个键值对
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // 获取所有存储的键
  Set<String> getAllKeys() {
    return _prefs?.getKeys() ?? {};
  }

  // 清除所有数据
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
