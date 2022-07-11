part of 'sign_out_cubit.dart';

@immutable
abstract class SignOutState {}

class SignOutInitial extends SignOutState {}

class SignOutLoading extends SignOutState {}

class SignOutSucceed extends SignOutState {}

class SignOutFailed extends SignOutState {
  final String errorMsg;
  SignOutFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignOutFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SignOutFailed(errorMsg: $errorMsg)';
}
