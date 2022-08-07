import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/garbage_request.dart';
import '../../../presentation/router/app_router.dart';

part 'send_request_state.dart';

class SendRequestCubit extends Cubit<SendRequestState> {
  SendRequestCubit() : super(SendRequestInitial());

  Future sendRequest({required GarbageRequest request}) async {
    try {
      emit(SendRequestSending());
      await Future.delayed(Duration(seconds: 2));
      GarbageRequest garbageRequest = await AppRouter.httpServices
          .createGarbageRequest(garbageRequest: request);
      emit(SendRequestSent(garbageRequest: garbageRequest));
    } catch (e) {
      emit(SendRequestFailed(errorMsg: e.toString()));
    }
  }
}
