import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/images/image_services.dart';

part 'get_image_state.dart';

class GetImageCubit extends Cubit<GetImageState> {
  GetImageCubit() : super(GetImageInitial());

  Future getImage({required bool isCamera}) async {
    try {
      emit(GetImageLoading());
      if (isCamera) {
        File image = await ImageServices.camImage();
        emit(GetImageLoaded(image: image));
      } else {
        File image = await ImageServices.galleryImage();
        emit(GetImageLoaded(image: image));
      }
    } catch (e) {
      emit(GetImageFailed(errorMsg: e.toString()));
    }
  }
}
