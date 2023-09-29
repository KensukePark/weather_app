import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Location {
  late double latitude2;
  late double longitude2;

  Future<void> getMyCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    var status_position = await Permission.location.status;
    if (status_position.isGranted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);

      latitude2 = position.latitude;
      longitude2 = position.longitude;

    } else {
      print("위치 권한이 필요합니다.");
    }
  }

}