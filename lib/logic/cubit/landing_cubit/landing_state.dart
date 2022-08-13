part of 'landing_cubit.dart';

@immutable
abstract class LandingState {}

class LandingInitial extends LandingState {}

class LandingLoading extends LandingState {}

class LandingToUser extends LandingState {
  final AppUser appUser;
  LandingToUser({
    required this.appUser,
  });
}

class LandingToDriver extends LandingState {
  final AppUser appUser;
  LandingToDriver({
    required this.appUser,
  });
}

class LandingToAuth extends LandingState {}

class LandingFailed extends LandingState {
  final String errorMsg;
  LandingFailed({
    required this.errorMsg,
  });
}
