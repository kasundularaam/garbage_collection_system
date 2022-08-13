import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

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
