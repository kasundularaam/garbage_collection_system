import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../core/components/components.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../data/models/app_user.dart';
import '../../../../../data/models/garbage_request.dart';
import '../../../../../logic/cubit/garbage_map_cubit/garbage_map_cubit.dart';

class GarbageMap extends StatefulWidget {
  final AppUser appUser;
  const GarbageMap({
    Key? key,
    required this.appUser,
  }) : super(key: key);

  @override
  State<GarbageMap> createState() => _GarbageMapState();
}

class _GarbageMapState extends State<GarbageMap> {
  AppUser get appUser => widget.appUser;

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
  void initState() {
    BlocProvider.of<GarbageMapCubit>(context).loadMap(appUser: appUser);
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<GarbageMapCubit>(context).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GarbageMapCubit, GarbageMapState>(
      listener: (context, state) {
        if (state is GarbageMapFailed) {
          showSnackBar(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        if (state is GarbageMapLoaded) {
          GarbageRequest req = state.request;

          return Container(
            color: AppColors.primaryColor,
            child: Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: colombo,
                    onMapCreated: (GoogleMapController controller) {
                      _truckLocation(
                          latLng: state.truckLocation, controller: controller);
                    },
                    markers: state.markers,
                    polylines: Set<Polyline>.of(state.polylines.values),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.w),
                  child: Card(
                    color: AppColors.light0,
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Strings.garbage,
                                width: 18.w,
                              ),
                              hSpacer(3),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textP("Garbage on ${req.location}", 16,
                                        bold: true),
                                    vSpacer(1),
                                    text("Garbage Type: ${req.garbageType}", 14,
                                        AppColors.dark3),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          vSpacer(1),
                          const Divider(
                            thickness: 2,
                          ),
                          vSpacer(1),
                          Row(
                            children: [
                              Expanded(
                                  child: textD("Mark garbage collected", 12)),
                              hSpacer(5.w),
                              buttonFilledP(
                                "Collected",
                                () => BlocProvider.of<GarbageMapCubit>(context)
                                    .loadMap(
                                  appUser: appUser,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is GarbageMapLoading) {
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
