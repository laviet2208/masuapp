import 'package:flutter/material.dart';
import 'dart:math';

class CaculateDistance {
  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Bán kính trái đất (đơn vị: km)

    // Chuyển đổi độ từ độ sang radian
    final double lat1Rad = lat1 * (pi / 180);
    final double lon1Rad = lon1 * (pi / 180);
    final double lat2Rad = lat2 * (pi / 180);
    final double lon2Rad = lon2 * (pi / 180);

    // Tính chênh lệch giữa kinh độ và vĩ độ
    final double dLat = lat2Rad - lat1Rad;
    final double dLon = lon2Rad - lon1Rad;

    // Sử dụng công thức Haversine để tính khoảng cách
    final double a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = earthRadius * c;

    return distance;
  }

  static List<double> parseDoubleString(String input) {
    List<String> parts = input.split(','); // Tách chuỗi theo dấu phẩy
    if (parts.length == 2) {
      try {
        double firstDouble = double.parse(parts[0].trim()); // Chuyển đổi thành số double
        double secondDouble = double.parse(parts[1].trim()); // Chuyển đổi thành số double
        return [firstDouble, secondDouble]; // Trả về mảng chứa hai số double
      } catch (e) {
        // Xử lý ngoại lệ nếu có lỗi khi chuyển đổi
        print('Lỗi: $e');
      }
    }
    return [0,0];
  }

}