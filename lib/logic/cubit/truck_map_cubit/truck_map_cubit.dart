import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utils/app_utils.dart';
import '../../../data/location/location_services.dart';
import '../../../data/models/truck_location.dart';
import '../../../data/socket_io/user.dart';

part 'truck_map_state.dart';

class TruckMapCubit extends Cubit<TruckMapState> {
  TruckMapCubit() : super(TruckMapInitial());

  UserSocket? _userSocket;

  Future loadMap() async {
    try {
      emit(TruckMapLoading());
      Set<Marker> markers = {};
      LocationData userLocation = await LocationServices.locationData;
      Marker user = await getMarker(
          markerId: "user",
          icon: Strings.user,
          latLng: LatLng(userLocation.latitude!, userLocation.longitude!),
          info: "");
      markers.add(user);

      _userSocket = UserSocket();

      if (_userSocket != null) {
        Stream<TruckLocation> stream = _userSocket!.getTruckLocations();
        stream.listen((truckLocation) async {
          Marker user = await getMarker(
              markerId: "truck_${truckLocation.id}",
              icon: Strings.truck,
              latLng: LatLng(truckLocation.lat, truckLocation.lng),
              info: "");
          markers.add(user);
          emit(
            TruckMapLoaded(
              markers: markers,
              userLocation: LatLng(
                userLocation.latitude!,
                userLocation.longitude!,
              ),
            ),
          );
        });
      }
    } catch (e) {
      dispose();
      emit(
        TruckMapFailed(
          errorMsg: e.toString(),
        ),
      );
    }
  }

  dispose() {
    _userSocket!.dispose();
  }
}
