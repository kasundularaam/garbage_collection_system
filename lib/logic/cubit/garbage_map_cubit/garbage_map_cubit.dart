import 'package:flutter_bloc/flutter_bloc.dart';

part 'garbage_map_state.dart';

class GarbageMapCubit extends Cubit<GarbageMapState> {
  GarbageMapCubit() : super(GarbageMapInitial());
}
