import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../data/models/app_user.dart';
import '../../../../data/models/garbage_request_req.dart';
import '../../../../logic/cubit/get_image_cubit/get_image_cubit.dart';
import '../../../../logic/cubit/road_garbage_cubit/road_garbage_cubit.dart';
import '../../../../logic/cubit/send_request_cubit/send_request_cubit.dart';
import '../../widgets/capture_card.dart';
import '../../widgets/request_button.dart';
import '../../widgets/weight_card.dart';

class RoadGarbagePage extends StatefulWidget {
  const RoadGarbagePage({Key? key}) : super(key: key);

  @override
  State<RoadGarbagePage> createState() => _RoadGarbagePageState();
}

class _RoadGarbagePageState extends State<RoadGarbagePage> {
  GarbageRequestReq? requestReq;

  @override
  Widget build(BuildContext context) {
    return page(Column(
      children: [
        simpleAppBar("Garbage On Road", context),
        BlocProvider(
          create: (context) => GetImageCubit(),
          child: CaptureCard(
            onCaptured: (image) => BlocProvider.of<RoadGarbageCubit>(context)
                .loadRoadGarbage(image: image),
          ),
        ),
        BlocConsumer<RoadGarbageCubit, RoadGarbageState>(
          listener: (context, state) {
            if (state is RoadGarbageLoaded) {
              AppUser user = state.appUser;
              requestReq = GarbageRequestReq(
                  user: "${user.id}",
                  mobileNo: user.mobileNo,
                  garbageType: "ALL",
                  location: "Road",
                  longitude: state.longitude,
                  latitude: state.latitude,
                  status: "PENDING");
            }
          },
          builder: (context, state) {
            if (state is RoadGarbageLoading) {
              return Expanded(
                child: Center(
                  child: viewSpinner(),
                ),
              );
            }
            if (state is RoadGarbageLoaded) {
              return Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  children: [
                    WeightCard(
                      onChange: (weight) => {},
                    ),
                    vSpacer(3),
                    BlocProvider(
                      create: (context) => SendRequestCubit(),
                      child: RequestButton(
                        request: requestReq!,
                      ),
                    ),
                    vSpacer(3),
                  ],
                ),
              );
            }
            return nothing;
          },
        ),
      ],
    ));
  }
}
