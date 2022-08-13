import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/http/http_services.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/login_res.dart';
import '../../../data/shared/shared_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      HttpServices httpServices = HttpServices();
      LoginRes loginRes =
          await httpServices.login(email: email, password: password);
      AppUser appUser = await httpServices.getUser(id: loginRes.id);
      SharedAuth.addUser(uid: appUser.id, type: appUser.type);
      emit(LoginSucceed());
    } catch (e) {
      emit(LoginFailed(errorMsg: e.toString()));
    }
  }
}
