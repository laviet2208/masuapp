import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

import '../../../../../Data/locationData/Location.dart';
import '../../../../../Data/otherData/Tool.dart';

class general_controller {
  static Future<double> getCost(Location startLocation, Location endLocation) async {
    double cost = 0;
    double distance = await getDistance(startLocation, endLocation);
    if (distance >= finalData.bikeCost.departKM) {
      cost += finalData.bikeCost.departKM.toInt() * finalData.bikeCost.departCost.toInt(); // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
      distance -= finalData.bikeCost.departKM; // Trừ đi 2km đã tính giá cước
      cost = cost + ((distance - finalData.bikeCost.departKM) * finalData.bikeCost.perKMcost);
    } else {
      cost += (distance * finalData.bikeCost.departCost); // Giá cước cho khoảng cách dưới 2km
    }
    //order.cost = cost;
    return cost;
  }

  static Future<double> get_total(List<Location> customerLocations, List<Location> bikeLocations, Location startLocation) async {
    double cost = 0;
    for (Location location in customerLocations) {
      cost = cost + await getCost(startLocation,location);
    }
    for (Location location in bikeLocations) {
      cost = cost + await getCost(startLocation,location);
    }
    return cost;
  }

}