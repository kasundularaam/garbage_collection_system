import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../logic/cubit/get_image_cubit/get_image_cubit.dart';
import '../../../../logic/cubit/road_garbage_cubit/road_garbage_cubit.dart';
import '../../widgets/capture_card.dart';
import '../../widgets/weight_card.dart';

class RoadGarbagePage extends StatefulWidget {
  const RoadGarbagePage({Key? key}) : super(key: key);

  @override
  State<RoadGarbagePage> createState() => _RoadGarbagePageState();
}

class _RoadGarbagePageState extends State<RoadGarbagePage> {
  @override
  Widget build(BuildContext context) {
    return page(Column(
      children: [
        simpleAppBar("Garbage On Road", context),
        BlocProvider(
          create: (context) => GetImageCubit(),
          child: CaptureCard(
            onCaptured: (image) => BlocProvider.of<RoadGarbageCubit>(context)
                .loadHomeGarbage(image: image),
          ),
        ),
        BlocBuilder<RoadGarbageCubit, RoadGarbageState>(
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
                    buttonFilledP("Send", () => {}),
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
