import '../utils/request.dart';

class OverviewApi {
  // 单例
  static OverviewApi? _instance;
  // 私有构造函数
  OverviewApi._internal();
  // 工厂函数
  factory OverviewApi() => _instance ?? OverviewApi._internal();
  // 单例getter
  static OverviewApi? get instance => _instance ?? OverviewApi._internal();

  // 当前功率 装机容量
  fetchPowerAndCapacity() async {
    return await Request().request('/api/plant/power/summary');
  }
  // 发电量
  fetchEnergySummary() async {
    return await Request().request('/api/plant/energy/summary');
  }
  // 在线 离线 异常数量
  fetchInverterStatusSummary() async {
    return await Request().request('/api/inverter/status/summary');
  }
  // 统计图 - 日
  fetchStatisticsDay() async{
    return await Request().request(
      '/api/user/daily/statistics',
      data: {
        "date": '2024-06-11',
      },
    );
  }
  // 统计图 - 月
  fetchStatisticsMonth() async{
    return await Request().request(
      '/api/monthly/statistics',
      data: {
        "yearMonth": '2024-06',
      },
    );
  }
  // 统计图 - 年
  fetchStatisticsYear() async{
    return await Request().request(
      '/api/yearly/statistics',
      data: {
        "year": '2024',
      },
    );
  }
}

final overviewApi = OverviewApi();