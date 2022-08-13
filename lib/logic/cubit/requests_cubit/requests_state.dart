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
}

class RequestsFailed extends RequestsState {
  final String errorMsg;
  RequestsFailed({
    required this.errorMsg,
  });
}
