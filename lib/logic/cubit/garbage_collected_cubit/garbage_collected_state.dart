part of 'garbage_collected_cubit.dart';

abstract class GarbageCollectedState {}

class GarbageCollectedInitial extends GarbageCollectedState {}

class GarbageCollectedUpdating extends GarbageCollectedState {}

class GarbageCollectedUpdated extends GarbageCollectedState {
  final GarbageRequest garbageRequest;
  GarbageCollectedUpdated({
    required this.garbageRequest,
  });
}

class GarbageCollectedFailed extends GarbageCollectedState {
  final String errorMsg;
  GarbageCollectedFailed({
    required this.errorMsg,
  });
}
