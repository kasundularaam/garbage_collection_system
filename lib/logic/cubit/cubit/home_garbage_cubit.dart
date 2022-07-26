import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_garbage_state.dart';

class HomeGarbageCubit extends Cubit<HomeGarbageState> {
  HomeGarbageCubit() : super(HomeGarbageInitial());

  Future loadHomeGarbage({required File image}) async {
    try {
      emit(HomeGarbageLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(HomeGarbageLoaded(contents: ["Idiot", "Asshole"]));
    } catch (e) {
      emit(HomeGarbageFailed(errorMsg: e.toString()));
    }
  }
}
