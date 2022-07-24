part of 'home_garbage_cubit.dart';

abstract class HomeGarbageState {}

class HomeGarbageInitial extends HomeGarbageState {}

class HomeGarbageLoading extends HomeGarbageState {}

class HomeGarbageLoaded extends HomeGarbageState {
  final List<String> contents;
  HomeGarbageLoaded({
    required this.contents,
  });

  @override
  String toString() => 'HomeGarbageLoaded(contents: $contents)';
}

class HomeGarbageFailed extends HomeGarbageState {
  final String errorMsg;
  HomeGarbageFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(covariant HomeGarbageFailed other) {
    if (identical(this, other)) return true;

    return other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'HomeGarbageFailed(errorMsg: $errorMsg)';
}
