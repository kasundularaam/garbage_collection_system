import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/app_user.dart';
import '../../../data/shared/shared_auth.dart';
import '../../../presentation/router/app_router.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      AppUser appUser =
          await AppRouter.httpServices.login(email: email, password: password);
      SharedAuth.addUser(uid: appUser.id, type: appUser.type);
      emit(LoginSucceed());
    } catch (e) {
      emit(LoginFailed(errorMsg: e.toString()));
    }
  }
}
