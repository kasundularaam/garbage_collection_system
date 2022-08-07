part of 'road_garbage_cubit.dart';

abstract class RoadGarbageState {}

class RoadGarbageInitial extends RoadGarbageState {}

class RoadGarbageLoading extends RoadGarbageState {}

class RoadGarbageLoaded extends RoadGarbageState {}

class RoadGarbageFailed extends RoadGarbageState {
  final String errorMsg;
  RoadGarbageFailed({
    required this.errorMsg,
  });

  @override
  String toString() => 'RoadGarbageFailed(errorMsg: $errorMsg)';
}
