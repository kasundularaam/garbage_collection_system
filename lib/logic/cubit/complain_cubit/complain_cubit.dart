import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/validator/validators.dart';
import '../../../data/http/http_services.dart';
import '../../../data/models/complain.dart';
import '../../../data/models/complain_req.dart';

part 'complain_state.dart';

class ComplainCubit extends Cubit<ComplainState> {
  ComplainCubit() : super(ComplainInitial());

  Future send({required ComplainReq complainReq}) async {
    try {
      emit(ComplainSending());
      complainValid(complainReq.detail);
      final HttpServices services = HttpServices();
      final Complain complain =
          await services.createComplain(complainReq: complainReq);
      emit(ComplainSent(complain: complain));
    } catch (e) {
      emit(ComplainFailed(errorMsg: e.toString()));
    }
  }
}
