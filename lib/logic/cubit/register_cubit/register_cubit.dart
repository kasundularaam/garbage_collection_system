import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_collection_system/data/models/app_user.dart';
import 'package:garbage_collection_system/data/models/register_req.dart';

import '../../../data/shared/shared_auth.dart';
import '../../../presentation/router/app_router.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future register({required RegisterReq registerReq}) async {
    try {
      emit(RegisterLoading());
      AppUser user =
          await AppRouter.httpServices.register(registerReq: registerReq);
      SharedAuth.addUser(uid: user.id, type: user.type);
      emit(RegisterSucceed(appUser: user));
    } catch (e) {
      emit(RegisterFailed(errorMsg: e.toString()));
    }
  }
}
