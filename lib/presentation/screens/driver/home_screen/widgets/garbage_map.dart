import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../core/components/components.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../data/models/app_user.dart';
import '../../../../../data/models/garbage_request.dart';
import '../../../../../logic/cubit/garbage_collected_cubit/garbage_collected_cubit.dart';
import '../../../../../logic/cubit/garbage_map_cubit/garbage_map_cubit.dart';
import 'map_loaded_view.dart';

class GarbageMap extends StatefulWidget {
  final AppUser appUser;
  const GarbageMap({
    Key? key,
    required this.appUser,
  }) : super(key: key);

  @override
  State<GarbageMap> createState() => _GarbageMapState();
}

class _GarbageMapState extends State<GarbageMap> {
  AppUser get appUser => widget.appUser;
  GarbageRequest? req;

  static const CameraPosition colombo = CameraPosition(
    target: LatLng(6.9271, 79.8612),
    zoom: 15,
  );

  update() {
    GarbageRequest request = req!.copyWith(status: "COLLECTED");
    BlocProvider.of<GarbageCollectedCubit>(context)
        .updateRequest(request: request);
  }

  @override
  void initState() {
    BlocProvider.of<GarbageMapCubit>(context).loadMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GarbageMapCubit, GarbageMapState>(
      listener: (context, state) {
        if (state is GarbageMapFailed) {
          showSnackBar(context, state.errorMsg);
        }
        if (state is GarbageMapLoaded) {
          req = state.request;
        }
      },
      builder: (context, state) {
        if (state is GarbageMapLoaded) {
          return Column(
            children: [
              Expanded(
                child: MapLoadedView(state: state),
              ),
              Container(
                color: AppColors.collected,
                child: Padding(
                  padding: EdgeInsets.all(1.w),
                  child: Card(
                    color: AppColors.light0,
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Strings.garbage,
                                width: 18.w,
                              ),
                              hSpacer(3),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textP(
                                        "garbage_location".tr(namedArgs: {
                                          "location": req!.location.tr()
                                        }),
                                        16,
                                        bold: true),
                                    vSpacer(1),
                                    text(
                                        "garbage_type".tr(namedArgs: {
                                          "type": req!.garbageType
                                        }),
                                        14,
                                        AppColors.dark3),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          vSpacer(1),
                          const Divider(
                            thickness: 2,
                          ),
                          vSpacer(1),
                          Row(
                            children: [
                              Expanded(child: textD("mark_collected".tr(), 12)),
                              hSpacer(5.w),
                              BlocConsumer<GarbageCollectedCubit,
                                  GarbageCollectedState>(
                                listener: (context, state) {
                                  if (state is GarbageCollectedFailed) {
                                    showSnackBar(context, state.errorMsg);
                                  }
                                  if (state is GarbageCollectedUpdated) {
                                    BlocProvider.of<GarbageMapCubit>(context)
                                        .loadMap();
                                  }
                                },
                                builder: (context, state) {
                                  if (state is GarbageCollectedUpdating) {
                                    return viewSpinner();
                                  }
                                  return buttonFilledP(
                                    "collected".tr(),
                                    () => update(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        if (state is GarbageMapAllCleaned) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Strings.done,
                width: 100.w,
                fit: BoxFit.fitWidth,
              ),
              vSpacer(3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textD("cleaned".tr(), 20, bold: true),
                  hSpacer(3),
                  Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.collected,
                    size: 25.sp,
                  )
                ],
              ),
            ],
          );
        }
        if (state is GarbageMapLoading) {
          return Center(child: viewSpinner());
        }
        return const GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: colombo,
        );
      },
    );
  }
}
