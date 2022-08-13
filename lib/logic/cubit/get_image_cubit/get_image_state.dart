part of 'get_image_cubit.dart';

abstract class GetImageState {}

class GetImageInitial extends GetImageState {}

class GetImageLoading extends GetImageState {}

class GetImageLoaded extends GetImageState {
  final File image;
  GetImageLoaded({
    required this.image,
  });
}

class GetImageFailed extends GetImageState {
  final String errorMsg;
  GetImageFailed({
    required this.errorMsg,
  });
}
