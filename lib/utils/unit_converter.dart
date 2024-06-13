String convertPower(dynamic power, {int decimalDigits = 2}) {
  // 如果参数是字符串，则尝试将其解析为数字
  if (power is String) {
    power = double.tryParse(power);
    if (power == null) {
      throw const FormatException('Invalid number format');
    }
  }

  power ??= 0;

  if (power >= 1e12) {
    return '${(power / 1e12).toStringAsFixed(decimalDigits)} TW'; // 转换为太瓦
  }
  else if (power >= 1e9) {
    return '${(power / 1e9).toStringAsFixed(decimalDigits)} GW'; // 转换为吉瓦
  }
  else if (power >= 1e6) {
    return '${(power / 1e6).toStringAsFixed(decimalDigits)} MW'; // 转换为兆瓦
  }
  else if (power >= 1e3) {
    return '${(power / 1e3).toStringAsFixed(decimalDigits)} kW'; // 转换为千瓦
  }
  else {
    return '${power.toStringAsFixed(decimalDigits)} W'; // 保持瓦不变
  }
}

String convertEnergy(dynamic energy, {int decimalDigits = 2}) {
  // 如果参数是字符串，则尝试将其解析为数字
  if (energy is String) {
    energy = double.tryParse(energy);
    if (energy == null) {
      throw const FormatException('Invalid number format');
    }
  }

  energy ??= 0;

  if (energy >= 1e12) {
    return '${(energy / 1e12).toStringAsFixed(decimalDigits)} TWh'; // 转换为太瓦时
  }
  else if (energy >= 1e9) {
    return '${(energy / 1e9).toStringAsFixed(decimalDigits)} GWh'; // 转换为吉瓦时
  }
  else if (energy >= 1e6) {
    return '${(energy / 1e6).toStringAsFixed(decimalDigits)} MWh'; // 转换为兆瓦时
  }
  else if (energy >= 1e3) {
    return '${(energy / 1e3).toStringAsFixed(decimalDigits)} kWh'; // 转换为千瓦时
  }
  else {
    return '${energy.toStringAsFixed(decimalDigits)} Wh'; // 保持瓦时不变
  }
}

