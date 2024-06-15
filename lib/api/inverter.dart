import '../utils/request.dart';

class InverterApi {
  // 单例
  static InverterApi? _instance;

  // 私有构造函数
  InverterApi._internal();

  // 工厂函数
  factory InverterApi() => _instance ?? InverterApi._internal();

  // 单例getter
  static InverterApi? get instance => _instance ?? InverterApi._internal();

  // 逆变器列表
  queryInverter({
    required String plantId,
    required String accessPointId,
    String? serialNo,
    required int page,
  }) {
    return Request().request(
      '/api/inverter/query',
      data: {
        "plantId": plantId,
        "accessPointId": accessPointId,
        "serialNo": serialNo,
        "page": page,
        "size": 20,
      },
    );
  }
  // 逆变器列表实时功率和发电量
  currentInvertersEvent(List serialNos) {
    return Request().request(
      '/api/current/inverters-event',
      data: {
        "serialNos": serialNos,
      },
    );
  }
  queryInverterDetail(String inverterSerialNo) {
    return Request().request(
      '/api/inverter/detail',
      data: {
        "inverterSerialNo": inverterSerialNo,
      },
    );
  }
}

final inverterApi = InverterApi();
