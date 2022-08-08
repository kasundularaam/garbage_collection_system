import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/garbage_request.dart';
import '../../../data/shared/shared_auth.dart';
import '../../../presentation/router/app_router.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsInitial());

  Future loadRequests() async {
    try {
      emit(RequestsLoading());
      Future.delayed(const Duration(seconds: 2));
      final int uid = await SharedAuth.getUid();
      final List<GarbageRequest> garbageRequests =
          await AppRouter.httpServices.getGarbageRequests(uid: uid);
      emit(RequestsLoaded(garbageRequests: garbageRequests));
    } catch (e) {
      emit(RequestsFailed(errorMsg: e.toString()));
    }
  }
}
