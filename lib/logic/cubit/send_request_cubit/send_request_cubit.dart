import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/garbage_request.dart';
import '../../../data/models/garbage_request_req.dart';
import '../../../presentation/router/app_router.dart';

part 'send_request_state.dart';

class SendRequestCubit extends Cubit<SendRequestState> {
  SendRequestCubit() : super(SendRequestInitial());

  Future sendRequest({required GarbageRequestReq request}) async {
    try {
      emit(SendRequestSending());
      GarbageRequest garbageRequest = await AppRouter.httpServices
          .createGarbageRequest(garbageRequestReq: request);
      emit(SendRequestSent(garbageRequest: garbageRequest));
    } catch (e) {
      log(e.toString());
      emit(SendRequestFailed(errorMsg: e.toString()));
    }
  }
}
