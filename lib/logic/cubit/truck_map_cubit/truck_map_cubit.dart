import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utils/app_utils.dart';
import '../../../data/firebase/store.dart';
import '../../../data/location/location_services.dart';

part 'truck_map_state.dart';

class TruckMapCubit extends Cubit<TruckMapState> {
  TruckMapCubit() : super(TruckMapInitial());

  Future loadMap() async {
    try {
      emit(TruckMapLoading());
      List<int> ids = [];
      List<Marker> markers = [];
      LocationData userLocation = await LocationServices.locationData();
      Marker user = await getMarker(
          markerId: "user",
          icon: Strings.user,
          latLng: LatLng(userLocation.latitude!, userLocation.longitude!),
          info: "");
      markers.add(user);

      emit(
        TruckMapLoaded(
          markers: {...markers},
          userLocation: LatLng(
            userLocation.latitude!,
            userLocation.longitude!,
          ),
        ),
      );

      MyFireStore.getLocations().listen((truckLocation) async {
        Marker truck = await getMarker(
            markerId: "truck_${truckLocation.id}",
            icon: Strings.truck,
            latLng: LatLng(truckLocation.lat, truckLocation.lng),
            info: "");
        if (ids.contains(truckLocation.id)) {
          markers[ids.indexOf(truckLocation.id) + 1] = truck;
        } else {
          ids.add(truckLocation.id);
          markers.add(truck);
        }
        if (isClosed) return;
        emit(
          TruckMapLoaded(
            markers: {...markers},
            userLocation: LatLng(
              userLocation.latitude!,
              userLocation.longitude!,
            ),
          ),
        );
      });
    } catch (e) {
      emit(
        TruckMapFailed(
          errorMsg: e.toString(),
        ),
      );
    }
  }
}
