part of 'targets_cubit.dart';

abstract class TargetsState extends Equatable {
  const TargetsState();

  @override
  List<Object> get props => [];
}

class TargetsInitial extends TargetsState {}

class TargetsLoading extends TargetsState {}

class TargetsLoaded extends TargetsState {
  final GarbageRequest target;
  final LatLng start;
  final LatLng end;
  const TargetsLoaded({
    required this.target,
    required this.start,
    required this.end,
  });

  @override
  List<Object> get props => [target, start, end];
}

class TargetsCompeted extends TargetsState {}

class TargetsFailed extends TargetsState {
  final String errorMsg;
  const TargetsFailed({
    required this.errorMsg,
  });

  @override
  List<Object> get props => [errorMsg];
}
