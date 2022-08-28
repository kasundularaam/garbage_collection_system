import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/http/http_services.dart';
import '../../../data/location/location_services.dart';
import '../../../data/models/app_user.dart';
import '../../../data/shared/shared_auth.dart';

part 'road_garbage_state.dart';

class RoadGarbageCubit extends Cubit<RoadGarbageState> {
  RoadGarbageCubit() : super(RoadGarbageInitial());

  Future loadRoadGarbage({required File image}) async {
    try {
      emit(RoadGarbageLoading());
      final int id = await SharedAuth.getUid();
      HttpServices httpServices = HttpServices();
      final AppUser appUser = await httpServices.getUser(id: id);
      final LatLng latLng = await LocationServices.latLng();
      emit(
        RoadGarbageLoaded(
          appUser: appUser,
          latitude: latLng.latitude,
          longitude: latLng.longitude,
        ),
      );
    } catch (e) {
      emit(RoadGarbageFailed(errorMsg: e.toString()));
    }
  }
}
