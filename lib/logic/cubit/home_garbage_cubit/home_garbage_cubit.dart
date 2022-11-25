import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/http/http_services.dart';
import '../../../data/location/location_services.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/image_res.dart';
import '../../../data/shared/shared_auth.dart';

part 'home_garbage_state.dart';

class HomeGarbageCubit extends Cubit<HomeGarbageState> {
  HomeGarbageCubit() : super(HomeGarbageInitial());

  Future loadHomeGarbage({required File image}) async {
    try {
      emit(HomeGarbageLoading());
      final HttpServices httpImageServices =
          await HttpServices.initialize(isImageServer: true);
      final ImageRes imageRes =
          await httpImageServices.analyzeImage(image: image);
      if (imageRes.status == "SUCCESS" && imageRes.result != "other") {
        final int id = await SharedAuth.getUid();
        final HttpServices httpServices = await HttpServices.initialize();
        final AppUser appUser = await httpServices.getUser(id: id);
        final LatLng latLng = await LocationServices.latLng();
        emit(
          HomeGarbageLoaded(
            content: imageRes.result,
            appUser: appUser,
            latitude: latLng.latitude,
            longitude: latLng.longitude,
          ),
        );
      } else {
        emit(HomeGarbageNotDetected());
      }
    } catch (e) {
      emit(HomeGarbageFailed(errorMsg: e.toString()));
    }
  }
}
