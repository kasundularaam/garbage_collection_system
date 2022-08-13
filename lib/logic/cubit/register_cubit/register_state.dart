part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSucceed extends RegisterState {
  final AppUser appUser;
  RegisterSucceed({
    required this.appUser,
  });
}

class RegisterFailed extends RegisterState {
  final String errorMsg;
  RegisterFailed({
    required this.errorMsg,
  });
}
