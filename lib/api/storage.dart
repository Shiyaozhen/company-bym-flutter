import 'package:BYM/utils/BYLog.dart';
import 'package:dio/dio.dart';

import '../utils/request.dart';

class StorageApi {
  // 单例
  static StorageApi? _instance;
  // 私有构造函数
  StorageApi._internal();
  // 工厂函数
  factory StorageApi() => _instance ?? StorageApi._internal();
  // 单例getter
  static StorageApi? get instance => _instance ?? StorageApi._internal();

  uploadImage(formData) {
    BYLog.i("upload: ${formData}");
    return Request().request(
      '/api/storage/image',
      options: Options(
        contentType: 'multipart/form-data'
      ),
      data: formData,
    );
  }
}

final storageApi = StorageApi();