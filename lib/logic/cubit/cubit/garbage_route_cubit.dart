import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/app_utils.dart';

part 'garbage_route_state.dart';

class GarbageRouteCubit extends Cubit<GarbageRouteState> {
  GarbageRouteCubit() : super(GarbageRouteInitial());

  Future loadRoute(
      {required LatLng startLocation, required LatLng endLocation}) async {
    try {
      emit(GarbageRouteLoading());
      Map<PolylineId, Polyline> polylines = {};

      List<LatLng> polylineCoordinates =
          await polylineCords(startLocation, endLocation);

      PolylineId id = const PolylineId("poly");
      Polyline polyline = Polyline(
        polylineId: id,
        color: AppColors.primaryColor,
        points: polylineCoordinates,
        width: 5,
      );
      polylines[id] = polyline;
      emit(GarbageRouteLoaded(polylines: polylines));
    } catch (e) {
      emit(GarbageRouteFailed(errorMsg: e.toString()));
    }
  }
}
