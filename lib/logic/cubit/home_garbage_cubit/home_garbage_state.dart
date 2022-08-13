// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_garbage_cubit.dart';

abstract class HomeGarbageState {}

class HomeGarbageInitial extends HomeGarbageState {}

class HomeGarbageLoading extends HomeGarbageState {}

class HomeGarbageLoaded extends HomeGarbageState {
  final List<String> contents;
  final AppUser appUser;
  final double latitude;
  final double longitude;
  HomeGarbageLoaded({
    required this.contents,
    required this.appUser,
    required this.latitude,
    required this.longitude,
  });
}

class HomeGarbageFailed extends HomeGarbageState {
  final String errorMsg;
  HomeGarbageFailed({
    required this.errorMsg,
  });
}
