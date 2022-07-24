import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../core/components/components.dart';
import '../../../../../../logic/cubit/truck_map_cubit/truck_map_cubit.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  Future<void> _userLocation({required LatLng latLng}) async {
    CameraPosition camPos = CameraPosition(
        bearing: 192.8334901395799,
        target: latLng,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(camPos));
  }

  static const CameraPosition colombo = CameraPosition(
    target: LatLng(6.9271, 79.8612),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TruckMapCubit, TruckMapState>(
      listener: (context, state) {
        if (state is TruckMapFailed) {
          showSnackBar(context, state.errorMsg);
        }
        if (state is TruckMapLoaded) {
          _userLocation(
              latLng: LatLng(
                  state.userLocation.latitude, state.userLocation.longitude));
        }
      },
      builder: (context, state) {
        if (state is TruckMapLoaded) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: colombo,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: state.trucks,
          );
        }
        if (state is TruckMapLoading) {
          return Center(child: viewSpinner());
        }
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: colombo,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        );
      },
    );
  }
}
