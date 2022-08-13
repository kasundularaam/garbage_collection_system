part of 'sign_out_cubit.dart';

abstract class SignOutState {}

class SignOutInitial extends SignOutState {}

class SignOutLoading extends SignOutState {}

class SignOutSucceed extends SignOutState {}

class SignOutFailed extends SignOutState {
  final String errorMsg;
  SignOutFailed({
    required this.errorMsg,
  });
}
