import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        final String uid = await SharedAuth.getUid();
        final AppUser appUser = AppUser(
            uid: uid, name: "berry", isDriver: false, email: "berry@gmail.com");
        emit(LandingToHome(appUser: appUser));
      } else {
        emit(LandingToAuth());
      }
    } catch (e) {
      emit(LandingFailed(errorMsg: e.toString()));
    }
  }
}
