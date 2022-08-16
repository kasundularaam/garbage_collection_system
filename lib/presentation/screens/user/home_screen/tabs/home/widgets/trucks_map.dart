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
  final Completer<GoogleMapController> _controller = Completer();

  Future<void> _userLocation({required LatLng latLng}) async {
    CameraPosition camPos = CameraPosition(target: latLng, zoom: 15);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(camPos));
  }

  static const CameraPosition colombo = CameraPosition(
    target: LatLng(6.9271, 79.8612),
    zoom: 15,
  );

  @override
  void dispose() {
    BlocProvider.of<TruckMapCubit>(context).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TruckMapCubit>(context).loadMap();
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
            markers: state.markers,
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
