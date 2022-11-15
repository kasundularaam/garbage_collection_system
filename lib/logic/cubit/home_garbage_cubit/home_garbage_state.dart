part of 'home_garbage_cubit.dart';

abstract class HomeGarbageState {}

class HomeGarbageInitial extends HomeGarbageState {}

class HomeGarbageLoading extends HomeGarbageState {}

class HomeGarbageLoaded extends HomeGarbageState {
  final String content;
  final AppUser appUser;
  final double latitude;
  final double longitude;
  HomeGarbageLoaded({
    required this.content,
    required this.appUser,
    required this.latitude,
    required this.longitude,
  });
}

class HomeGarbageNotDetected extends HomeGarbageState {}

class HomeGarbageFailed extends HomeGarbageState {
  final String errorMsg;
  HomeGarbageFailed({
    required this.errorMsg,
  });
}
