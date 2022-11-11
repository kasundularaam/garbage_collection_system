import 'dart:math';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/garbage_request.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

Future<Marker> getMarker(
    {required String markerId,
    required String icon,
    required LatLng latLng,
    required String info}) async {
  final Uint8List markerIcon = await getBytesFromAsset(icon, 100);
  final Marker marker = Marker(
      markerId: MarkerId(markerId),
      position: latLng,
      infoWindow: InfoWindow(title: info),
      icon: BitmapDescriptor.fromBytes(markerIcon));

  return marker;
}

GarbageRequest nearestRequest(
    List<GarbageRequest> requests, double lat, double long) {
  if (requests.length == 1) {
    return requests[0];
  }
  double min =
      calculateDistance(lat, long, requests[0].latitude, requests[0].longitude);
  GarbageRequest nearestReq = requests[0];
  for (var request in requests) {
    double distance =
        calculateDistance(lat, long, request.latitude, request.longitude);

    if (distance < min) {
      min = distance;
      nearestReq = request;
    }
  }
  return nearestReq;
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * log(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

Future<List<LatLng>> polylineCords(
    LatLng startLocation, LatLng endLocation) async {
  try {
    List<LatLng> polylineCoordinates = [];

    PolylinePoints polylinePoints = PolylinePoints();
    String googleAPiKey = "AIzaSyC2juTDRi7wjau4qkfjPWJeEevTqTTWPt8";

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      return polylineCoordinates;
    } else {
      throw "route_error".tr();
    }
  } catch (e) {
    throw "route_error".tr();
  }
}
