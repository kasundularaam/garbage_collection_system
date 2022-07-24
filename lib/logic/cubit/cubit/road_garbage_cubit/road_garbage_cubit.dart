import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'road_garbage_state.dart';

class RoadGarbageCubit extends Cubit<RoadGarbageState> {
  RoadGarbageCubit() : super(RoadGarbageInitial());

  Future loadHomeGarbage({required File image}) async {
    try {
      emit(RoadGarbageLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(RoadGarbageLoaded());
    } catch (e) {
      emit(RoadGarbageFailed(errorMsg: e.toString()));
    }
  }
}
