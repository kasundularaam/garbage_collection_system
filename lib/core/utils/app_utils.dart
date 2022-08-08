import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
