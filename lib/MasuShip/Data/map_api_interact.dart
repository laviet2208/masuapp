import 'locationData/Location.dart';
import 'otherData/Tool.dart';

class map_api_interact {
  static Future<double> getMaxDistance(List<Location> list, Location start) async {
    double maxdistance = 0;
    for (Location location in list) {
      double distance = await getDistance(location, start);
      if (distance > maxdistance) {
        maxdistance = distance;
      }
    }
    return maxdistance;
  }
}