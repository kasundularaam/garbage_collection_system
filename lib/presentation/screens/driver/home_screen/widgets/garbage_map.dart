import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_collection_system/data/models/garbage_request.dart';
import 'package:garbage_collection_system/logic/cubit/garbage_map_cubit/garbage_map_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../core/components/components.dart';
import '../../../../../core/themes/app_colors.dart';

class GarbageMap extends StatefulWidget {
  const GarbageMap({Key? key}) : super(key: key);

  @override
  State<GarbageMap> createState() => _GarbageMapState();
}

class _GarbageMapState extends State<GarbageMap> {
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
  Widget build(BuildContext context) {
    BlocProvider.of<GarbageMapCubit>(context).loadMap();

    return BlocConsumer<GarbageMapCubit, GarbageMapState>(
      listener: (context, state) {
        if (state is GarbageMapFailed) {
          showSnackBar(context, state.errorMsg);
        }
        if (state is GarbageMapLoaded) {
          _userLocation(
              latLng: LatLng(
                  state.userLocation.latitude, state.userLocation.longitude));
        }
      },
      builder: (context, state) {
        if (state is GarbageMapLoaded) {
          GarbageRequest req = state.request;
          return Column(
            children: [
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: colombo,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: state.markers,
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textP("Garbage on ${req.location}", 16, bold: true),
                      vSpacer(2),
                      text("Type: ${req.garbageType}", 14, AppColors.dark3),
                      vSpacer(2),
                      Center(child: buttonFilledP("Collected", () => {}))
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        if (state is GarbageMapLoading) {
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
