part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucceed extends LoginState {}

class LoginFailed extends LoginState {
  final String errorMsg;
  LoginFailed({
    required this.errorMsg,
  });
}
