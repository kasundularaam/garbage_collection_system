import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../../core/components/components.dart';
import '../../../../../../../logic/cubit/truck_map_cubit/truck_map_cubit.dart';

class TrucksMap extends StatefulWidget {
  const TrucksMap({Key? key}) : super(key: key);

  @override
  State<TrucksMap> createState() => _TrucksMapState();
}

class _TrucksMapState extends State<TrucksMap> {
  Future<void> _userLocation(
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
    BlocProvider.of<TruckMapCubit>(context).loadMap();
    return BlocConsumer<TruckMapCubit, TruckMapState>(
      listener: (context, state) {
        if (state is TruckMapFailed) {
          showSnackBar(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        if (state is TruckMapLoaded) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: colombo,
            onMapCreated: (GoogleMapController controller) {
              _userLocation(latLng: state.userLocation, controller: controller);
            },
            markers: state.markers,
          );
        }
        if (state is TruckMapLoading) {
          return Center(child: viewSpinner());
        }
        return const GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: colombo,
        );
      },
    );
  }
}
