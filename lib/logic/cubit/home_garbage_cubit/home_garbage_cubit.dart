import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import '../../../data/http/http_services.dart';
import '../../../data/location/location_services.dart';
import '../../../data/models/app_user.dart';
import '../../../data/shared/shared_auth.dart';

part 'home_garbage_state.dart';

class HomeGarbageCubit extends Cubit<HomeGarbageState> {
  HomeGarbageCubit() : super(HomeGarbageInitial());

  Future loadHomeGarbage({required File image}) async {
    try {
      emit(HomeGarbageLoading());
      final int id = await SharedAuth.getUid();
      HttpServices httpServices = HttpServices();
      final AppUser appUser = await httpServices.getUser(id: id);
      final LocationData location = await LocationServices.locationData;
      emit(HomeGarbageLoaded(
          contents: ["Plastic", "Paper"],
          appUser: appUser,
          latitude: location.latitude!,
          longitude: location.longitude!));
    } catch (e) {
      emit(HomeGarbageFailed(errorMsg: e.toString()));
    }
  }
}
