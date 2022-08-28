import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utils/app_utils.dart';
import '../../../data/models/app_user.dart';
import '../../../data/socket_io/driver.dart';

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

  final DriverSocket _driverSocket = DriverSocket();

  Future loadMap() async {
    try {
      emit(GarbageMapLoading());

      Set<Marker> markers = {};

      Marker targetMarker = await getMarker(
          markerId: "target",
          icon: Strings.truck,
          latLng: LatLng(target.latitude, target.longitude),
          info: "");

      Marker truckInitMarker = await getMarker(
          markerId: "truck",
          icon: Strings.truck,
          latLng: LatLng(start.latitude, start.longitude),
          info: "");

      markers.add(targetMarker);
      markers.add(truckInitMarker);

      _driverSocket.sendData(appUser: appUser).listen((location) async {
        Marker truckTrackMarker = await getMarker(
            markerId: "truck",
            icon: Strings.truck,
            latLng: LatLng(location.lat, location.lng),
            info: "");
        markers = markers
            .map((item) =>
                item.markerId.value == "truck" ? truckTrackMarker : item)
            .toSet();
        emit(
          GarbageMapLoaded(
              markers: markers,
              trackLocation: LatLng(location.lat, location.lng)),
        );
      });
    } catch (e) {
      emit(GarbageMapFailed(errorMsg: e.toString()));
    }
  }
}
