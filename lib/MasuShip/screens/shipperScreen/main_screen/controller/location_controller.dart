import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

import '../../../../../GENERAL/utils/utils.dart';

class location_controller {
  static late StreamSubscription<Position> positionStream;

  static Future<void> updateLocationToDatabase(Position position) async {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference reference = database.reference().child('Account').child(finalData.account.id).child('location');

    // Update location to database
    await reference.child('latitude').set(position.latitude);

    await reference.child('longitude').set(position.longitude);
  }

  static void startLocationTracking() {
    positionStream = Geolocator.getPositionStream().listen((Position position) async {
      // Cập nhật vị trí vào cơ sở dữ liệu khi vị trí thay đổi
      await updateLocationToDatabase(position);
    });
  }

  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Chưa cho phép vị trí');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        toastMessage('Để tiếp tục bạn cần cho phép truy cập vị trí của bạn');
        exit(0);
        return Future.error('Từ chối cho phép vị trí');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      toastMessage('Để tiếp tục bạn cần cho phép truy cập vị trí của bạn');
      exit(0);
      return Future.error('Bạn cần cho phép ứng dụng truy cập vào vị trí');
    }

    Position position = await Geolocator.getCurrentPosition();

    // Start tracking location changes
    startLocationTracking();

    return position;
  }
}