import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../logic/cubit/garbage_map_cubit/garbage_map_cubit.dart';

class MapLoadedView extends StatefulWidget {
  final GarbageMapLoaded state;
  const MapLoadedView({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  State<MapLoadedView> createState() => _MapLoadedViewState();
}

class _MapLoadedViewState extends State<MapLoadedView> {
  GarbageMapLoaded get state => widget.state;
  Future<void> _truckLocation(
      {required LatLng latLng, required GoogleMapController controller}) async {
    CameraPosition camPos = CameraPosition(target: latLng, zoom: 15);
    controller.animateCamera(CameraUpdate.newCameraPosition(camPos));
  }

  static const CameraPosition colombo = CameraPosition(
    target: LatLng(6.9271, 79.8612),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: colombo,
      onMapCreated: (GoogleMapController controller) {
        _truckLocation(latLng: state.truckLocation, controller: controller);
      },
      markers: state.markers,
      polylines: Set<Polyline>.of(state.polylines.values),
    );
  }
}
