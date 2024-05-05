import 'dart:convert';
import 'package:crypto/crypto.dart';

class HmacUtil {
  static String generateHmacSHA256(String data, String key) {
    var bytesKey = utf8.encode(key);
    var bytesData = utf8.encode(data);
    
    var hmacSha256 = Hmac(sha256, bytesKey);
    var digest = hmacSha256.convert(bytesData);
    
    return digest.toString();
  }
}
