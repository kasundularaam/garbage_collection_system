import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../data/location/location_services.dart';

part 'truck_map_state.dart';

class TruckMapCubit extends Cubit<TruckMapState> {
  TruckMapCubit() : super(TruckMapInitial());

  Future loadMap() async {
    try {
      emit(TruckMapLoading());
      LocationData userLocation = await LocationServices.locationData;
    } catch (e) {
      emit(TruckMapFailed(errorMsg: e.toString()));
    }
  }
}
