part of 'garbage_map_cubit.dart';

abstract class GarbageMapState {}

class GarbageMapInitial extends GarbageMapState {}

class GarbageMapLoading extends GarbageMapState {}

class GarbageMapLoaded extends GarbageMapState {
  final Set<Marker> markers;
  final LatLng userLocation;
  final GarbageRequest request;
  GarbageMapLoaded({
    required this.markers,
    required this.userLocation,
    required this.request,
  });
}

class GarbageMapFailed extends GarbageMapState {
  final String errorMsg;
  GarbageMapFailed({
    required this.errorMsg,
  });
}
