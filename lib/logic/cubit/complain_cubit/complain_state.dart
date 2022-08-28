// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'complain_cubit.dart';

abstract class ComplainState extends Equatable {
  const ComplainState();

  @override
  List<Object> get props => [];
}

class ComplainInitial extends ComplainState {}

class ComplainSending extends ComplainState {}

class ComplainSent extends ComplainState {
  final Complain complain;
  const ComplainSent({
    required this.complain,
  });

  @override
  List<Object> get props => [complain];
}

class ComplainFailed extends ComplainState {
  final String errorMsg;
  const ComplainFailed({
    required this.errorMsg,
  });

  @override
  List<Object> get props => [errorMsg];
}
