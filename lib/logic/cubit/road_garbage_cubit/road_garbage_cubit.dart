import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_collection_system/data/location/location_services.dart';
import 'package:garbage_collection_system/data/models/app_user.dart';
import 'package:garbage_collection_system/data/shared/shared_auth.dart';
import 'package:garbage_collection_system/presentation/router/app_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

part 'road_garbage_state.dart';

class RoadGarbageCubit extends Cubit<RoadGarbageState> {
  RoadGarbageCubit() : super(RoadGarbageInitial());

  Future loadRoadGarbage({required File image}) async {
    try {
      emit(RoadGarbageLoading());
      final int id = await SharedAuth.getUid();
      final AppUser appUser = await AppRouter.httpServices.getUser(id: id);
      final LocationData location = await LocationServices.locationData;
      emit(RoadGarbageLoaded(
          appUser: appUser,
          latitude: location.latitude!,
          longitude: location.longitude!));
    } catch (e) {
      emit(RoadGarbageFailed(errorMsg: e.toString()));
    }
  }
}
