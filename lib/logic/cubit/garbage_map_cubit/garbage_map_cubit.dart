import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_collection_system/data/firebase/store.dart';
import 'package:garbage_collection_system/data/location/location_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utils/app_utils.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/truck_location.dart';

part 'garbage_map_state.dart';

class GarbageMapCubit extends Cubit<GarbageMapState> {
  final AppUser appUser;
  final LatLng target;
  final LatLng start;
  GarbageMapCubit({
    required this.appUser,
    required this.target,
    required this.start,
  }) : super(GarbageMapInitial());

  Future loadMap() async {
    try {
      emit(GarbageMapLoading());

      Set<Marker> markers = {};

      Marker targetMarker = await getMarker(
          markerId: "target",
          icon: Strings.garbage,
          latLng: LatLng(target.latitude, target.longitude),
          info: "");

      Marker truckInitMarker = await getMarker(
          markerId: "truck",
          icon: Strings.truck,
          latLng: LatLng(start.latitude, start.longitude),
          info: "");

      markers.add(targetMarker);
      markers.add(truckInitMarker);

      LocationServices.locationStream.listen((location) async {
        await MyFireStore.updateTruck(
            truckLocation: TruckLocation(
          id: appUser.id,
          name: appUser.username,
          lat: location.latitude!,
          lng: location.longitude!,
          mobileNum: appUser.mobileNo,
        ));

        Marker truckTrackMarker = await getMarker(
            markerId: "truck",
            icon: Strings.truck,
            latLng: LatLng(location.latitude!, location.longitude!),
            info: "");
        markers = markers
            .map((item) =>
                item.markerId.value == "truck" ? truckTrackMarker : item)
            .toSet();
        if (isClosed) return;
        emit(
          GarbageMapLoaded(
              markers: markers,
              trackLocation: LatLng(location.latitude!, location.longitude!)),
        );
      });
    } catch (e) {
      emit(GarbageMapFailed(errorMsg: e.toString()));
    }
  }
}
