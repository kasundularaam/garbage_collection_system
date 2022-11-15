import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/app_utils.dart';
import '../../../data/http/http_services.dart';
import '../../../data/location/location_services.dart';
import '../../../data/models/garbage_request.dart';

part 'targets_state.dart';

class TargetsCubit extends Cubit<TargetsState> {
  TargetsCubit() : super(TargetsInitial());

  Future loadTargets() async {
    try {
      emit(TargetsLoading());
      final HttpServices services = await HttpServices.initialize();
      final List<GarbageRequest> targets =
          await services.getNewGarbageRequests();
      if (targets.isNotEmpty) {
        LatLng truckLocation = await LocationServices.latLng();

        GarbageRequest nearest = nearestRequest(
            targets, truckLocation.latitude, truckLocation.longitude);

        emit(
          TargetsLoaded(
            target: nearest,
            start: truckLocation,
            end: LatLng(
              nearest.latitude,
              nearest.longitude,
            ),
          ),
        );
      } else {
        emit(TargetsCompeted());
      }
    } catch (e) {
      emit(TargetsFailed(errorMsg: e.toString()));
    }
  }
}
