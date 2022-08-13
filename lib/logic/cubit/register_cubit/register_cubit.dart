import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/http/http_services.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/register_req.dart';
import '../../../data/shared/shared_auth.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future register({required RegisterReq registerReq}) async {
    try {
      emit(RegisterLoading());
      HttpServices httpServices = HttpServices();
      AppUser user = await httpServices.register(registerReq: registerReq);
      SharedAuth.addUser(uid: user.id, type: user.type);
      emit(RegisterSucceed(appUser: user));
    } catch (e) {
      emit(RegisterFailed(errorMsg: e.toString()));
    }
  }
}
