// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'complains_cubit.dart';

abstract class ComplainsState extends Equatable {
  const ComplainsState();

  @override
  List<Object> get props => [];
}

class ComplainsInitial extends ComplainsState {}

class ComplainsLoading extends ComplainsState {}

class ComplainsLoaded extends ComplainsState {
  final List<Complain> complains;
  const ComplainsLoaded({
    required this.complains,
  });

  @override
  List<Object> get props => [complains];
}

class ComplainsFailed extends ComplainsState {
  final String errorMsg;
  const ComplainsFailed({
    required this.errorMsg,
  });

  @override
  List<Object> get props => [errorMsg];
}
