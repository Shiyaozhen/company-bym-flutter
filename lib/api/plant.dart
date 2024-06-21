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

  // 获取图表数据
  fetchPlantChartDataDay({required String plantId, required String date}) {
    return Request().request(
      '/api/plant/daily/statistics',
      data: {
        "plantId": plantId,
        "date": date,
      },
    );
  }
  fetchPlantChartDataMonth({required String plantId, required String date}) {
    return Request().request(
      '/api/monthly/statistics',
      data: {
        "plantId": plantId,
        "yearMonth": date,
      },
    );
  }
  fetchPlantChartDataYear({required String plantId, required String date}) {
    return Request().request(
      '/api/yearly/statistics',
      data: {
        "plantId": plantId,
        "year": date,
      },
    );
  }
}

final plantApi = PlantApi();