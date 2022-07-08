import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/app_user.dart';
import '../../../data/shared/shared_services.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(LandingInitial());

  Future loadApp() async {
    try {
      emit(LandingLoading());
      await Future.delayed(const Duration(seconds: 2));
      final bool isUserIn = await SharedServices.isUserIn();
      if (isUserIn) {
        final String uid = await SharedServices.getUid();
        final AppUser appUser = AppUser(uid: uid, name: "name");
        emit(LandingToHome(appUser: appUser));
      } else {
        emit(LandingToAuth());
      }
    } catch (e) {
      emit(LandingFailed(errorMsg: e.toString()));
    }
  }
}
