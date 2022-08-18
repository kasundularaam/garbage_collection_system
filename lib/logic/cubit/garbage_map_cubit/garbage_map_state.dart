part of 'garbage_map_cubit.dart';

abstract class GarbageMapState {
  get polylines => null;
}

class GarbageMapInitial extends GarbageMapState {}

class GarbageMapLoading extends GarbageMapState {}

class GarbageMapLoaded extends GarbageMapState {
  final Set<Marker> markers;
  final LatLng truckLocation;
  final GarbageRequest request;
  Map<PolylineId, Polyline> polylines;
  GarbageMapLoaded({
    required this.markers,
    required this.truckLocation,
    required this.request,
    required this.polylines,
  });
}

class GarbageMapFailed extends GarbageMapState {
  final String errorMsg;
  GarbageMapFailed({
    required this.errorMsg,
  });
}
