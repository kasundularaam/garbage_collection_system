import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future login({required String nic, required String password}) async {
    try {
      emit(LoginLoading());
      // bool succeed = await Repository.login(nic: nic, password: password);
      // if (succeed) {
      //   OJLKUser user = await Repository.getSlbfeUser(nic: nic);
      //   SharedServices.addUser(uid: user.id);
      //   emit(LoginSucceed());
      // } else {
      //   emit(LoginFailed(errorMsg: "Wrong credentials"));
      // }
    } catch (e) {
      emit(LoginFailed(errorMsg: e.toString()));
    }
  }
}
