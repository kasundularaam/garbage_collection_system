import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'garbage_collected_state.dart';

class GarbageCollectedCubit extends Cubit<GarbageCollectedState> {
  GarbageCollectedCubit() : super(GarbageCollectedInitial());
}
