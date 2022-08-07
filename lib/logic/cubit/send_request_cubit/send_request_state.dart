part of 'send_request_cubit.dart';

abstract class SendRequestState {}

class SendRequestInitial extends SendRequestState {}

class SendRequestSending extends SendRequestState {}

class SendRequestSent extends SendRequestState {
  final GarbageRequest garbageRequest;
  SendRequestSent({
    required this.garbageRequest,
  });
}

class SendRequestFailed extends SendRequestState {
  final String errorMsg;
  SendRequestFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(covariant SendRequestFailed other) {
    if (identical(this, other)) return true;

    return other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SendRequestFailed(errorMsg: $errorMsg)';
}
