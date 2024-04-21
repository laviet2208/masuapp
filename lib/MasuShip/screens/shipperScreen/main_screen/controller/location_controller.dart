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
    DatabaseReference reference = database.reference().child('Account').child(finalData.user_account.id).child('location');
    if (finalData.user_account.id == '') {
      reference = database.reference().child('Account').child(finalData.shipper_account.id).child('location');
    }

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
      return Position(longitude: 106.4204177, latitude: 10.5375044, timestamp: DateTime(2024), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1);
      //return Future.error('Chưa cho phép vị trí');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        toastMessage('Nên cho phép vị trí để tăng cường trải nghiệm');
        return Position(longitude: 106.4204177, latitude: 10.5375044, timestamp: DateTime(2024), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1);
        // exit(0);
        // return Future.error('Từ chối cho phép vị trí');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      toastMessage('Nên cho phép vị trí để tăng cường trải nghiệm');
      return Position(longitude: 106.4204177, latitude: 10.5375044, timestamp: DateTime(2024), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1);
      // exit(0);
      // return Future.error('Bạn cần cho phép ứng dụng truy cập vào vị trí');
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      // Start tracking location changes
      startLocationTracking();
      return await Geolocator.getCurrentPosition();
    }


    return Position(longitude: 106.4204177, latitude: 10.5375044, timestamp: DateTime(2024), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1);
  }
}