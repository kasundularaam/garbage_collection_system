import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_collection_system/data/models/garbage_request.dart';
import 'package:garbage_collection_system/presentation/router/app_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utils/app_utils.dart';
import '../../../data/location/location_services.dart';

part 'garbage_map_state.dart';

class GarbageMapCubit extends Cubit<GarbageMapState> {
  GarbageMapCubit() : super(GarbageMapInitial());

  Future loadMap() async {
    try {
      emit(GarbageMapLoading());
      Set<Marker> markers = {};
      LocationData userLocation = await LocationServices.locationData;
      Marker user = await getMarker(
          markerId: "user",
          icon: Strings.truck,
          latLng: LatLng(userLocation.latitude!, userLocation.longitude!),
          info: "");
      markers.add(user);

      final List<GarbageRequest> requests =
          await AppRouter.httpServices.getNewGarbageRequests();

      GarbageRequest nearest = nearestRequest(
          requests, userLocation.latitude!, userLocation.longitude!);

      Marker request = await getMarker(
          markerId: "request",
          icon: Strings.garbage,
          latLng: LatLng(nearest.latitude, nearest.longitude),
          info: "");

      markers.add(request);

      emit(
        GarbageMapLoaded(
          request: nearest,
          markers: markers,
          userLocation: LatLng(userLocation.latitude!, userLocation.longitude!),
        ),
      );
    } catch (e) {
      emit(GarbageMapFailed(errorMsg: e.toString()));
    }
  }
}
