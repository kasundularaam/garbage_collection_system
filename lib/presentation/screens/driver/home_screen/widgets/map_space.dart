import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/components/components.dart';
import '../../../../../data/models/app_user.dart';
import '../../../../../logic/cubit/cubit/garbage_route_cubit.dart';
import '../../../../../logic/cubit/garbage_map_cubit/garbage_map_cubit.dart';
import 'garbage_map.dart';

class MapSpace extends StatelessWidget {
  final AppUser appUser;
  final LatLng endLocation;
  final LatLng startLocation;
  const MapSpace({
    Key? key,
    required this.appUser,
    required this.endLocation,
    required this.startLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GarbageRouteCubit>(context)
        .loadRoute(startLocation: startLocation, endLocation: endLocation);
    return BlocConsumer<GarbageRouteCubit, GarbageRouteState>(
      listener: (context, state) {
        if (state is GarbageRouteFailed) {
          showSnackBar(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        if (state is GarbageRouteLoading) {
          return Center(child: viewSpinner());
        }
        if (state is GarbageRouteLoaded) {
          return BlocProvider(
            create: (context) => GarbageMapCubit(
                appUser: appUser, start: startLocation, target: endLocation),
            child: GarbageMap(
              polylines: state.polylines,
            ),
          );
        }
        return nothing;
      },
    );
  }
}
