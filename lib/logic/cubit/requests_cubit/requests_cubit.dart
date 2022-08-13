import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/http/http_services.dart';
import '../../../data/models/garbage_request.dart';
import '../../../data/shared/shared_auth.dart';
import '../../../presentation/router/app_router.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsInitial());

  Future loadRequests() async {
    try {
      emit(RequestsLoading());
      final int uid = await SharedAuth.getUid();
      HttpServices httpServices = HttpServices();
      final List<GarbageRequest> garbageRequests =
          await httpServices.getGarbageRequestsById(uid: uid);
      emit(RequestsLoaded(garbageRequests: garbageRequests));
    } catch (e) {
      emit(RequestsFailed(errorMsg: e.toString()));
    }
  }
}
