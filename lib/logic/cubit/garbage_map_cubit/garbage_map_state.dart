part of 'garbage_map_cubit.dart';

abstract class GarbageMapState extends Equatable {
  const GarbageMapState();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GarbageMapInitial extends GarbageMapState {}

class GarbageMapLoading extends GarbageMapState {}

class GarbageMapLoaded extends GarbageMapState {
  final Set<Marker> markers;
  final LatLng trackLocation;
  const GarbageMapLoaded({
    required this.markers,
    required this.trackLocation,
  });

  @override
  List<Object?> get props => [markers, trackLocation];
}

class GarbageMapFailed extends GarbageMapState {
  final String errorMsg;
  const GarbageMapFailed({
    required this.errorMsg,
  });

  @override
  List<Object?> get props => [errorMsg];
}
