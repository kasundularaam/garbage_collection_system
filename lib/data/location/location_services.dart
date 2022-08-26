import 'package:easy_localization/easy_localization.dart';
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
        return Future.error('location_off'.tr());
      }
    }
    return true;
  }

  static Future<bool> isPermissionGranted() async {
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error('location_permission_error'.tr());
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
      throw "error".tr();
    }
  }
}
