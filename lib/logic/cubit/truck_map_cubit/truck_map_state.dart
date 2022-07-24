part of 'truck_map_cubit.dart';

@immutable
abstract class TruckMapState {}

class TruckMapInitial extends TruckMapState {}

class TruckMapLoading extends TruckMapState {}

class TruckMapLoaded extends TruckMapState {
  final Set<Marker> trucks;
  final LatLng userLocation;
  TruckMapLoaded({
    required this.trucks,
    required this.userLocation,
  });

  @override
  bool operator ==(covariant TruckMapLoaded other) {
    if (identical(this, other)) return true;

    return setEquals(other.trucks, trucks) &&
        other.userLocation == userLocation;
  }

  @override
  int get hashCode => trucks.hashCode ^ userLocation.hashCode;

  @override
  String toString() =>
      'TruckMapLoaded(trucks: $trucks, userLocation: $userLocation)';
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
