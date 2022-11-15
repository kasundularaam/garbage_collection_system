import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/http/http_services.dart';
import '../../../data/models/garbage_request.dart';

part 'garbage_collected_state.dart';

class GarbageCollectedCubit extends Cubit<GarbageCollectedState> {
  GarbageCollectedCubit() : super(GarbageCollectedInitial());

  Future updateRequest({required GarbageRequest request}) async {
    try {
      emit(GarbageCollectedUpdating());
      final HttpServices services = await HttpServices.initialize();
      final GarbageRequest updated =
          await services.updateGarbageRequest(request: request);
      emit(GarbageCollectedUpdated(garbageRequest: updated));
    } catch (e) {
      emit(GarbageCollectedFailed(errorMsg: e.toString()));
    }
  }
}
