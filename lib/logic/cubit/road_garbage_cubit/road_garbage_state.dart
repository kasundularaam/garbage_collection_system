part of 'road_garbage_cubit.dart';

abstract class RoadGarbageState {}

class RoadGarbageInitial extends RoadGarbageState {}

class RoadGarbageLoading extends RoadGarbageState {}

class RoadGarbageLoaded extends RoadGarbageState {
  final AppUser appUser;
  final double latitude;
  final double longitude;
  RoadGarbageLoaded({
    required this.appUser,
    required this.latitude,
    required this.longitude,
  });
}

class RoadGarbageFailed extends RoadGarbageState {
  final String errorMsg;
  RoadGarbageFailed({
    required this.errorMsg,
  });
}
