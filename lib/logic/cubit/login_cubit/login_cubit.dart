import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/http/http_services.dart';
import '../../../data/models/app_user.dart';
import '../../../data/shared/shared_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      HttpServices httpServices = HttpServices();
      AppUser appUser =
          await httpServices.login(email: email, password: password);
      SharedAuth.addUser(uid: appUser.uid, isDriver: appUser.isDriver);
      emit(LoginSucceed());
    } catch (e) {
      emit(LoginFailed(errorMsg: e.toString()));
    }
  }
}
