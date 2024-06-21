import '../utils/request.dart';

class StatisticsApi {
  // 单例
  static StatisticsApi? _instance;
  // 私有构造函数
  StatisticsApi._internal();
  // 工厂函数
  factory StatisticsApi() => _instance ?? StatisticsApi._internal();
  // 单例getter
  static StatisticsApi? get instance => _instance ?? StatisticsApi._internal();

  // 用户
  getUserYearlyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getUserMonthlyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getUserDailyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getUserMinutelyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getUserCapacitySummary() {
    return Request().request(
      '',
      data: {

      },
    );
  }

  // 电站
  getPlantYearlyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getPlantMonthlyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getPlantDailyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getPlantMinutelyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getPlantPowerSummary() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getPlantEnergySummary() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getPlantRuntime(List plantIds) {
    return Request().request(
      '/api/plant/runtime',
      data: {
        "plantIds": plantIds,
      },
    );
  }

  // 接入点
  getAccessPointYearlyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getAccessPointMonthlyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getAccessPointDailyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getAccessPointMinutelyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getAccessPointRuntime() {
    return Request().request(
      '',
      data: {

      },
    );
  }

  // 逆变器
  getInverterYearlyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getInverterMonthlyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getInverterDailyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getInverterMinutelyStatistics() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getInverterStatusSummary() {
    return Request().request(
      '',
      data: {

      },
    );
  }
  getInverterRuntime() {
    return Request().request(
      '',
      data: {

      },
    );
  }
}

final statisticsApi = StatisticsApi();