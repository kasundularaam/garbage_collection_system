part of 'requests_cubit.dart';

@immutable
abstract class RequestsState {}

class RequestsInitial extends RequestsState {}

class RequestsLoading extends RequestsState {}

class RequestsLoaded extends RequestsState {
  final List<GarbageRequest> garbageRequests;
  RequestsLoaded({
    required this.garbageRequests,
  });

  @override
  bool operator ==(covariant RequestsLoaded other) {
    if (identical(this, other)) return true;

    return listEquals(other.garbageRequests, garbageRequests);
  }

  @override
  int get hashCode => garbageRequests.hashCode;

  @override
  String toString() => 'RequestsLoaded(garbageRequests: $garbageRequests)';
}

class RequestsFailed extends RequestsState {
  final String errorMsg;
  RequestsFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(covariant RequestsFailed other) {
    if (identical(this, other)) return true;

    return other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'RequestsFailed(errorMsg: $errorMsg)';
}
