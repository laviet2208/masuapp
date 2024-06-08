import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';

class dashboard_controller {
  static Duration time_of_one_catch_order(CatchOrder order) {
    DateTime start = DateTime(order.S2time.year, order.S2time.month, order.S2time.day, order.S2time.hour, order.S2time.minute, order.S2time.minute);
    DateTime end = DateTime(order.S2time.year, order.S2time.month, order.S2time.day, order.S2time.hour, order.S2time.minute, order.S2time.minute);
    if (order.S4time.day != 0) {
      end = DateTime(order.S4time.year, order.S4time.month, order.S4time.day, order.S4time.hour, order.S4time.minute, order.S4time.minute);
    } else {
      if (order.S3time.day != 0) {
        end = DateTime(order.S3time.year, order.S3time.month, order.S3time.day, order.S3time.hour, order.S3time.minute, order.S3time.minute);
      }
    }
    return end.difference(start);
  }

  static Duration total_time_of_catch_order(List<CatchOrder> list) {
    Duration duration = DateTime(0,0,0,0,0,0).difference(DateTime(0,0,0,0,0,0));
    for (CatchOrder order in list) {
      duration = duration + time_of_one_catch_order(order);
    }
    return duration;
  }

  static Duration time_of_one_catch_3_order(catchOrderType3 order) {
    DateTime start = DateTime(order.S2time.year, order.S2time.month, order.S2time.day, order.S2time.hour, order.S2time.minute, order.S2time.minute);
    DateTime end = DateTime(order.S2time.year, order.S2time.month, order.S2time.day, order.S2time.hour, order.S2time.minute, order.S2time.minute);
    if (order.S4time.day != 0) {
      end = DateTime(order.S4time.year, order.S4time.month, order.S4time.day, order.S4time.hour, order.S4time.minute, order.S4time.minute);
    } else {
      if (order.S3time.day != 0) {
        end = DateTime(order.S3time.year, order.S3time.month, order.S3time.day, order.S3time.hour, order.S3time.minute, order.S3time.minute);
      }
    }
    return end.difference(start);
  }

  static Duration total_time_of_catch_3_order(List<catchOrderType3> list) {
    Duration duration = DateTime(0,0,0,0,0,0).difference(DateTime(0,0,0,0,0,0));
    for (catchOrderType3 order in list) {
      duration = duration + time_of_one_catch_3_order(order);
    }
    return duration;
  }

  static Duration time_of_one_express_order(expressOrder order) {
    DateTime start = DateTime(order.S2time.year, order.S2time.month, order.S2time.day, order.S2time.hour, order.S2time.minute, order.S2time.minute);
    DateTime end = DateTime(order.S2time.year, order.S2time.month, order.S2time.day, order.S2time.hour, order.S2time.minute, order.S2time.minute);
    if (order.S4time.day != 0) {
      end = DateTime(order.S4time.year, order.S4time.month, order.S4time.day, order.S4time.hour, order.S4time.minute, order.S4time.minute);
    } else {
      if (order.S3time.day != 0) {
        end = DateTime(order.S3time.year, order.S3time.month, order.S3time.day, order.S3time.hour, order.S3time.minute, order.S3time.minute);
      }
    }
    return end.difference(start);
  }

  static Duration total_time_of_express_order(List<expressOrder> list) {
    Duration duration = DateTime(0,0,0,0,0,0).difference(DateTime(0,0,0,0,0,0));
    for (expressOrder order in list) {
      duration = duration + time_of_one_express_order(order);
    }
    return duration;
  }

  static Duration time_of_one_request_order(requestBuyOrder order) {
    DateTime start = DateTime(order.S2time.year, order.S2time.month, order.S2time.day, order.S2time.hour, order.S2time.minute, order.S2time.minute);
    DateTime end = DateTime(order.S2time.year, order.S2time.month, order.S2time.day, order.S2time.hour, order.S2time.minute, order.S2time.minute);
    if (order.S4time.day != 0) {
      end = DateTime(order.S4time.year, order.S4time.month, order.S4time.day, order.S4time.hour, order.S4time.minute, order.S4time.minute);
    } else {
      if (order.S3time.day != 0) {
        end = DateTime(order.S3time.year, order.S3time.month, order.S3time.day, order.S3time.hour, order.S3time.minute, order.S3time.minute);
      }
    }
    return end.difference(start);
  }

  static Duration total_time_of_request_order(List<requestBuyOrder> list) {
    Duration duration = DateTime(0,0,0,0,0,0).difference(DateTime(0,0,0,0,0,0));
    for (requestBuyOrder order in list) {
      duration = duration + time_of_one_request_order(order);
    }
    return duration;
  }

  static Duration time_of_one_food_order(foodOrder order) {
    DateTime start = DateTime(order.timeList[1].year, order.timeList[1].month, order.timeList[1].day, order.timeList[1].hour, order.timeList[1].minute, order.timeList[1].minute);
    DateTime end = DateTime(order.timeList[1].year, order.timeList[1].month, order.timeList[1].day, order.timeList[1].hour, order.timeList[1].minute, order.timeList[1].minute);
    if (order.timeList[5].day != 0) {
      end = DateTime(order.timeList[5].year, order.timeList[5].month, order.timeList[5].day, order.timeList[5].hour, order.timeList[5].minute, order.timeList[5].minute);
    } else if (order.timeList[4].day != 0) {
      if (order.timeList[4].day != 0) {
        end = DateTime(order.timeList[4].year, order.timeList[4].month, order.timeList[4].day, order.timeList[4].hour, order.timeList[4].minute, order.timeList[4].minute);
      }
    } else if (order.timeList[3].day != 0) {
      if (order.timeList[3].day != 0) {
        end = DateTime(order.timeList[3].year, order.timeList[3].month, order.timeList[3].day, order.timeList[3].hour, order.timeList[3].minute, order.timeList[3].minute);
      }
    } else if (order.timeList[2].day != 0) {
      if (order.timeList[2].day != 0) {
        end = DateTime(order.timeList[2].year, order.timeList[2].month, order.timeList[2].day, order.timeList[2].hour, order.timeList[2].minute, order.timeList[2].minute);
      }
    }
    return start.difference(end);
  }

  static Duration total_time_of_food_order(List<foodOrder> list) {
    Duration duration = DateTime(0,0,0,0,0,0).difference(DateTime(0,0,0,0,0,0));
    for (foodOrder order in list) {
      duration = duration + time_of_one_food_order(order);
    }
    return duration;
  }

  static double get_total_catch_income(List<CatchOrder> list) {
    double money = 0;
    for (CatchOrder order in list) {
      money = order.cost - getShipDiscount(order.cost, order.costFee) + order.subFee;
    }
    return money;
  }

  static double get_total_catch_3_income(List<catchOrderType3> list) {
    double money = 0;
    for (catchOrderType3 order in list) {
      money = getShipDiscount(order.cost, order.costFee) + order.subFee;
    }
    return money;
  }

  static double get_total_express_income(List<expressOrder> list) {
    double money = 0;
    for (expressOrder order in list) {
      money = getShipDiscount(order.cost, order.costFee) + order.subFee;
    }
    return money;
  }

  static double get_total_request_income(List<requestBuyOrder> list) {
    double money = 0;
    for (requestBuyOrder order in list) {
      money = getShipDiscount(order.cost, order.costFee) + order.subFee;
    }
    return money;
  }

  static double get_total_food_income(List<foodOrder> list) {
    double money = 0;
    for (foodOrder order in list) {
      money = getShipDiscount(order.cost, order.costFee) + order.waitFee + order.weatherFee;
    }
    return money;
  }
}