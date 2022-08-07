import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/app_user.dart';
import '../../../data/shared/shared_auth.dart';
import '../../../presentation/router/app_router.dart';

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
        AppUser appUser = await AppRouter.httpServices.getUser(uid: uid);
        emit(LandingToHome(appUser: appUser));
      } else {
        emit(LandingToAuth());
      }
    } catch (e) {
      emit(LandingFailed(errorMsg: e.toString()));
    }
  }
}
