import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/http/http_services.dart';
import '../../../data/models/garbage_request.dart';
import '../../../data/models/garbage_request_req.dart';

part 'send_request_state.dart';

class SendRequestCubit extends Cubit<SendRequestState> {
  SendRequestCubit() : super(SendRequestInitial());

  Future sendRequest({required GarbageRequestReq request}) async {
    try {
      emit(SendRequestSending());
      HttpServices httpServices = HttpServices();
      GarbageRequest garbageRequest =
          await httpServices.createGarbageRequest(garbageRequestReq: request);
      emit(SendRequestSent(garbageRequest: garbageRequest));
    } catch (e) {
      emit(SendRequestFailed(errorMsg: e.toString()));
    }
  }
}
