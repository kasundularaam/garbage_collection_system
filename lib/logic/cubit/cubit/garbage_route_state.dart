part of 'garbage_route_cubit.dart';

abstract class GarbageRouteState extends Equatable {
  const GarbageRouteState();

  @override
  List<Object> get props => [];
}

class GarbageRouteInitial extends GarbageRouteState {}

class GarbageRouteLoading extends GarbageRouteState {}

class GarbageRouteLoaded extends GarbageRouteState {
  final Map<PolylineId, Polyline> polylines;
  const GarbageRouteLoaded({
    required this.polylines,
  });

  @override
  List<Object> get props => [polylines];
}

class GarbageRouteFailed extends GarbageRouteState {
  final String errorMsg;
  const GarbageRouteFailed({
    required this.errorMsg,
  });

  @override
  List<Object> get props => [errorMsg];
}
