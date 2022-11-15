import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/app_user.dart';
import '../../../../data/models/garbage_request_req.dart';
import '../../../../logic/cubit/get_image_cubit/get_image_cubit.dart';
import '../../../../logic/cubit/home_garbage_cubit/home_garbage_cubit.dart';
import '../../../../logic/cubit/send_request_cubit/send_request_cubit.dart';
import '../../widgets/capture_card.dart';
import '../../widgets/request_button.dart';
import '../../widgets/weight_card.dart';

class HomeGarbagePage extends StatefulWidget {
  const HomeGarbagePage({Key? key}) : super(key: key);

  @override
  State<HomeGarbagePage> createState() => _HomeGarbagePageState();
}

class _HomeGarbagePageState extends State<HomeGarbagePage> {
  GarbageRequestReq? requestReq;

  @override
  Widget build(BuildContext context) {
    return page(
      Column(
        children: [
          simpleAppBar("home_garbage".tr(), context),
          BlocProvider(
            create: (context) => GetImageCubit(),
            child: CaptureCard(
              onCaptured: (image) => BlocProvider.of<HomeGarbageCubit>(context)
                  .loadHomeGarbage(image: image),
            ),
          ),
          BlocConsumer<HomeGarbageCubit, HomeGarbageState>(
            listener: (context, state) {
              if (state is HomeGarbageLoaded) {
                AppUser user = state.appUser;
                requestReq = GarbageRequestReq(
                    user: "${user.id}",
                    mobileNo: user.mobileNo,
                    garbageType: state.content,
                    location: "Home",
                    longitude: state.longitude,
                    latitude: state.latitude,
                    status: "PENDING");
              }
            },
            builder: (context, state) {
              if (state is HomeGarbageLoading) {
                return Expanded(
                  child: Center(
                    child: viewSpinner(),
                  ),
                );
              }
              if (state is HomeGarbageLoaded) {
                final List<String> contents = [state.content];
                return Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    children: [
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textD("contains".tr(), 16, bold: true),
                              vSpacer(1),
                              Wrap(
                                spacing: 2.w,
                                children: contents
                                    .map((e) => Chip(
                                          label: textL(e, 12),
                                          backgroundColor:
                                              AppColors.primaryColor,
                                        ))
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                      WeightCard(
                        onChange: (weight) => {},
                      ),
                      vSpacer(2),
                      textD("inform_truck".tr(), 12),
                      vSpacer(1),
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
              if (state is HomeGarbageNotDetected) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Image.asset(
                      Strings.noGarbage,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                );
              }
              if (state is HomeGarbageFailed) {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Image.asset(
                            Strings.error,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      textD("error".tr(), 12),
                      vSpacer(3)
                    ],
                  ),
                );
              }
              return nothing;
            },
          )
        ],
      ),
    );
  }
}
