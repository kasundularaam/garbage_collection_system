import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/http/http_services.dart';
import '../../../data/models/app_user.dart';
import '../../../data/shared/shared_auth.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(LandingInitial());

  Future loadApp() async {
    try {
      emit(LandingLoading());
      await Future.delayed(const Duration(seconds: 2));
      final bool isUserIn = await SharedAuth.isUserIn();
      if (isUserIn) {
        final int uid = await SharedAuth.getUid();
        final bool isDriver = await SharedAuth.isDriver();
        HttpServices httpServices = HttpServices();
        AppUser appUser = await httpServices.getUser(id: uid);
        if (isDriver) {
          emit(LandingToDriver(appUser: appUser));
        } else {
          emit(LandingToUser(appUser: appUser));
        }
      } else {
        emit(LandingToAuth());
      }
    } catch (e) {
      emit(LandingFailed(errorMsg: e.toString()));
    }
  }
}
