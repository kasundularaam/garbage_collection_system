import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../../core/components/components.dart';
import '../../../../../logic/cubit/garbage_map_cubit/garbage_map_cubit.dart';

class GarbageMap extends StatelessWidget {
  final Map<PolylineId, Polyline> polylines;
  const GarbageMap({
    Key? key,
    required this.polylines,
  }) : super(key: key);

  static const CameraPosition colombo = CameraPosition(
    target: LatLng(6.9271, 79.8612),
    zoom: 15,
  );

  Future<void> _truckLocation(
      {required LatLng latLng, required GoogleMapController controller}) async {
    CameraPosition camPos = CameraPosition(target: latLng, zoom: 15);
    controller.animateCamera(
      CameraUpdate.newCameraPosition(camPos),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GarbageMapCubit>(context).loadMap();

    return BlocConsumer<GarbageMapCubit, GarbageMapState>(
      listener: (context, state) {
        if (state is GarbageMapFailed) {
          showSnackBar(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        if (state is GarbageMapLoading) {
          return Center(child: viewSpinner());
        }
        if (state is GarbageMapLoaded) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: colombo,
            onMapCreated: (GoogleMapController controller) {
              _truckLocation(
                  latLng: state.trackLocation, controller: controller);
            },
            markers: state.markers,
            polylines: Set<Polyline>.of(polylines.values),
          );
        }
        return const GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: colombo,
        );
      },
    );
  }
}
