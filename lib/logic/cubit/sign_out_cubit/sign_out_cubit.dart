import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/shared/shared_services.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit() : super(SignOutInitial());

  Future signOut() async {
    try {
      emit(SignOutSucceed());
      await SharedServices.removeUser();
      emit(SignOutSucceed());
    } catch (e) {
      emit(SignOutFailed(errorMsg: e.toString()));
    }
  }
}
