import 'package:location/location.dart';

class LocationServices {
  static Location location = Location();

  static Stream<LocationData> get locationStream => location.onLocationChanged;
  static Future<LocationData> get locationData => location.getLocation();

  static Future<bool> isServiceEnabled() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }
    return true;
  }

  static Future<bool> isPermissionGranted() async {
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }
    return true;
  }

  static Future<bool> isServiceAvailable() async {
    try {
      final bool permissionGranted = await isPermissionGranted();
      final bool serviceEnabled = await isServiceEnabled();
      if (permissionGranted && serviceEnabled) {
        return true;
      }
      return false;
    } catch (e) {
      throw e.toString();
    }
  }
}
