import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/http/http_services.dart';
import '../../../data/models/complain.dart';

part 'complains_state.dart';

class ComplainsCubit extends Cubit<ComplainsState> {
  ComplainsCubit() : super(ComplainsInitial());

  Future loadComplains({required String reqId}) async {
    try {
      emit(ComplainsLoading());
      final HttpServices services = HttpServices();
      final List<Complain> complains =
          await services.getComplains(reqId: reqId);
      emit(ComplainsLoaded(complains: complains));
    } catch (e) {
      emit(ComplainsFailed(errorMsg: e.toString()));
    }
  }
}
