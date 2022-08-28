import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/components/components.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../data/models/garbage_request.dart';
import '../../../../../logic/cubit/garbage_collected_cubit/garbage_collected_cubit.dart';
import '../../../../../logic/cubit/targets_cubit/targets_cubit.dart';

class DetailCard extends StatelessWidget {
  final GarbageRequest request;
  const DetailCard({
    Key? key,
    required this.request,
  }) : super(key: key);

  update({required BuildContext context}) {
    GarbageRequest collected = request.copyWith(status: "COLLECTED");
    BlocProvider.of<GarbageCollectedCubit>(context)
        .updateRequest(request: collected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                                "location": request.location.tr()
                              }),
                              16,
                              bold: true),
                          vSpacer(1),
                          text(
                              "garbage_type"
                                  .tr(namedArgs: {"type": request.garbageType}),
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
                    BlocConsumer<GarbageCollectedCubit, GarbageCollectedState>(
                      listener: (context, state) {
                        if (state is GarbageCollectedFailed) {
                          showSnackBar(context, state.errorMsg);
                        }
                        if (state is GarbageCollectedUpdated) {
                          BlocProvider.of<TargetsCubit>(context).loadTargets();
                        }
                      },
                      builder: (context, state) {
                        if (state is GarbageCollectedUpdating) {
                          return viewSpinner();
                        }
                        return buttonFilledP(
                          "collected".tr(),
                          () => update(context: context),
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
    );
  }
}
