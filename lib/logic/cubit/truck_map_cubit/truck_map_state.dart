// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'truck_map_cubit.dart';

@immutable
abstract class TruckMapState {}

class TruckMapInitial extends TruckMapState {}

class TruckMapLoading extends TruckMapState {}

class TruckMapLoaded extends TruckMapState {
  final Set<Marker> markers;
  final LatLng userLocation;
  TruckMapLoaded({
    required this.markers,
    required this.userLocation,
  });
}

class TruckMapFailed extends TruckMapState {
  final String errorMsg;
  TruckMapFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TruckMapFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'TruckMapFailed(errorMsg: $errorMsg)';
}
