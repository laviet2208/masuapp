import 'package:firebase_database/firebase_database.dart';

import '../../../../../../../Data/OrderData/foodOrder/foodOrder.dart';
import '../../../../../../../Data/accountData/shopData/cartProduct.dart';
import '../../../../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../../../../../Data/costData/Cost.dart';
import '../../../../../../../Data/locationData/Location.dart';
import '../../../../../../../Data/otherData/Tool.dart';

class delete_food_controller {
  //cập nhật lại danh sách nhà hàng
  static Future<void> add_restaurant_to_list(List<cartProduct> list, List<ShopAccount> shops) async {
    shops.clear();
    for (cartProduct cartproduct in list) {
      if (shops.any((shop) => shop.id == cartproduct.product.owner)) {

      } else {
        ShopAccount account = await get_restaurant_info(cartproduct.product.owner);
        shops.add(account);
      }
    }
  }

  static Future<double> getMaxCost(foodOrder order) async {
    double maxcost = 0;
    for (ShopAccount shop in order.shopList) {
      double cost = await getCostFuture(order.locationGet, shop.location, order.costFee);
      if (cost > maxcost) {
        maxcost = cost;
      }
    }
    return maxcost;
  }

  static Future<double> getCostFuture(Location startLocation, Location endLocation, Cost bikeCost) async {
    double cost = 0;
    double distance = await getDistance(startLocation, endLocation);
    cost = getShipCost(distance, bikeCost);
    return cost;
  }

  static Future<double> getMaxDistance(foodOrder order) async {
    double maxdistance = 0;
    for (ShopAccount shop in order.shopList) {
      double cost = await getDistance(order.locationGet, shop.location);
      if (cost > maxdistance) {
        maxdistance = cost;
        order.locationSet = shop.location;
      }
    }
    return maxdistance;
  }

  static Future<ShopAccount> get_restaurant_info(String id) async {
    dynamic orders;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Restaurant").child(id).once().then((DatabaseEvent event) {
      orders = event.snapshot.value;
    });
    return ShopAccount.fromJson(orders);
  }

  static Future<void> push_food_order_data(foodOrder order) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order').child(order.id).set(order.toJson());
  }

}