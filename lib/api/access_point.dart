import '../utils/request.dart';

class AccessPointApi {
  // 单例
  static AccessPointApi? _instance;

  // 私有构造函数
  AccessPointApi._internal();

  // 工厂函数
  factory AccessPointApi() => _instance ?? AccessPointApi._internal();

  // 单例getter
  static AccessPointApi? get instance =>
      _instance ?? AccessPointApi._internal();

  // 接入点列表
  queryAccessPoint(String plantId, String? serialNo, int page) {
    return Request().request(
      '/api/access-point/query',
      data: {
        "page": page,
        "size": 20,
        "plantId": plantId,
        "serialNo": serialNo,
      },
    );
  }

  // 实时数据
  fetchAccessPointRuntime(List serialNos) {
    return Request().request(
      ' /api/access-point/runtime',
      data: {"serialNos": serialNos},
    );
  }

  // 接入点详情
  fetchAccessPointDetail(String serialNo) {
    return Request().request(
      '/api/access-point/detail',
      data: {
        "serialNo": serialNo,
      },
    );
  }

  // 接入点
  fetchAccessPointStatus(String serialNo) {
    return Request().request(
      '/api/access-point/status',
      data: {
        "serialNo": serialNo,
      },
    );
  }

  // 删除接入点
  deleteAccessPoint(String id) {
    return Request().request(
      '/api/access-point/delete',
      data: {
        "id": id,
      },
    );
  }
}

final accessPointApi = AccessPointApi();