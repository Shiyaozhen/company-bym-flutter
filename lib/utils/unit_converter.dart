String convertPower(dynamic power, {int decimalDigits = 2, String invalidValueString = '---'}) {
  // 如果参数是字符串，则尝试将其解析为数字
  if (power is String) {
    power = double.tryParse(power);
    if (power == null) {
      return invalidValueString;
    }
  }

  // 如果 power 仍然是 null，返回指定的字符串
  if (power == null) {
    return invalidValueString;
  }

  if (power >= 1e12) {
    return '${(power / 1e12).toStringAsFixed(decimalDigits)} TW'; // 转换为太瓦
  } else if (power >= 1e9) {
    return '${(power / 1e9).toStringAsFixed(decimalDigits)} GW'; // 转换为吉瓦
  } else if (power >= 1e6) {
    return '${(power / 1e6).toStringAsFixed(decimalDigits)} MW'; // 转换为兆瓦
  } else if (power >= 1e3) {
    return '${(power / 1e3).toStringAsFixed(decimalDigits)} kW'; // 转换为千瓦
  } else {
    return '${power.toStringAsFixed(decimalDigits)} W'; // 保持瓦不变
  }
}

String convertEnergy(dynamic energy, {int decimalDigits = 2, String invalidValueString = '---'}) {
  // 如果参数是字符串，则尝试将其解析为数字
  if (energy is String) {
    energy = double.tryParse(energy);
    if (energy == null) {
      return invalidValueString;
    }
  }

  // 如果 energy 仍然是 null，返回指定的字符串
  if (energy == null) {
    return invalidValueString;
  }

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

