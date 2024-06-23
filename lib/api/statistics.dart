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
  getUserYearlyStatistics(String year) {
    return Request().request(
      '/api/user/yearly/statistics',
      data: {
        "year": year,
      },
    );
  }
  getUserMonthlyStatistics(String yearMonth) {
    return Request().request(
      '/api/user/monthly/statistics',
      data: {
        "yearMonth": yearMonth,
      },
    );
  }
  getUserDailyStatistics(String date) {
    return Request().request(
      '/api/user/daily/statistics',
      data: {
        "date": date,
      },
    );
  }
  getUserMinutelyStatistics(String date) {
    return Request().request(
      '/api/user/minutely/statistics',
      data: {
        "date": date,
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
  getPlantYearlyStatistics(String plantId, String year) {
    return Request().request(
      '/api/plant/yearly/statistics',
      data: {
        "plantId": plantId,
        "year": year,
      },
    );
  }
  getPlantMonthlyStatistics(String plantId, String yearMonth) {
    return Request().request(
      '/api/plant/yearly/statistics',
      data: {
        "plantId": plantId,
        "yearMonth": yearMonth,
      },
    );
  }
  getPlantDailyStatistics(String plantId, String date) {
    return Request().request(
      '/api/plant/daily/statistics',
      data: {
        "plantId": plantId,
        "date": date,
      },
    );
  }
  getPlantMinutelyStatistics(String plantId, String date) {
    return Request().request(
      '/api/plant/minutely/statistics',
      data: {
        "plantId": plantId,
        "date": date,
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
  getInverterYearlyStatistics(String inverterSerialNo, String year) {
    return Request().request(
      '/api/inverter/yearly/statistics',
      data: {
        "inverterSerialNo": inverterSerialNo,
        "year": year,
      },
    );
  }
  getInverterMonthlyStatistics(String inverterSerialNo, String yearMonth) {
    return Request().request(
      '/api/inverter/monthly/statistics',
      data: {
        "inverterSerialNo": inverterSerialNo,
        "yearMonth": yearMonth,
      },
    );
  }
  getInverterDailyStatistics(String inverterSerialNo, String date) {
    return Request().request(
      '/api/inverter/daily/statistics',
      data: {
        "inverterSerialNo": inverterSerialNo,
        "date": date,
      },
    );
  }
  getInverterMinutelyStatistics(String inverterSerialNo, String date) {
    return Request().request(
      '/api/inverter/minutely/statistics',
      data: {
        "inverterSerialNo": inverterSerialNo,
        "date": date,
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