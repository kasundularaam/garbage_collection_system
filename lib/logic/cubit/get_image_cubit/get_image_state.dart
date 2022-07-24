part of 'get_image_cubit.dart';

abstract class GetImageState {}

class GetImageInitial extends GetImageState {}

class GetImageLoading extends GetImageState {}

class GetImageLoaded extends GetImageState {
  final File image;
  GetImageLoaded({
    required this.image,
  });

  @override
  String toString() => 'GetImageLoaded(image: $image)';
}

class GetImageFailed extends GetImageState {
  final String errorMsg;
  GetImageFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(covariant GetImageFailed other) {
    if (identical(this, other)) return true;

    return other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'GetImageFailed(errorMsg: $errorMsg)';
}
