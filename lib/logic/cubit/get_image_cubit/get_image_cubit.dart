import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/images/image_services.dart';

part 'get_image_state.dart';

class GetImageCubit extends Cubit<GetImageState> {
  GetImageCubit() : super(GetImageInitial());

  Future getImage() async {
    try {
      emit(GetImageLoading());
      final File image = await ImageServices.camImage();
      log(image.toString());
      emit(GetImageLoaded(image: image));
    } catch (e) {
      emit(GetImageFailed(errorMsg: e.toString()));
    }
  }
}
