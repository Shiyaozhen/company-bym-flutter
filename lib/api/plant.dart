import '../utils/request.dart';

class PlantApi {
  // 单例
  static PlantApi? _instance;
  // 私有构造函数
  PlantApi._internal();
  // 工厂函数
  factory PlantApi() => _instance ?? PlantApi._internal();
  // 单例getter
  static PlantApi? get instance => _instance ?? PlantApi._internal();

  // 电站列表
  queryPlant({
    int page = 1,
    int size = 10,
    String? name,
  }) async {
    return await Request().request(
      '/api/plant/query',
      data: {
        "page": page,
        "size": size,
        "name": name,
      },
    );
  }
  // 删除电站
  deletePlant(String id) async {
    return await Request().request(
      '/api/plant/delete',
      data: {
        "id": id,
      },
    );
  }

  fetchPlantPowerSummary(dynamic plantId) {
    return Request().request(
      '/api/plant/power/summary',
      data: {
        "plantId": plantId,
      },
    );
  }
  fetchPlantEnergySummary(dynamic plantId) {
    return Request().request(
      '/api/plant/energy/summary',
      data: {
        "plantId": plantId,
      },
    );
  }
}

final plantApi = PlantApi();