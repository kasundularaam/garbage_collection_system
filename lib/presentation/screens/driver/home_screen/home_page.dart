// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/app_user.dart';
import '../../../../logic/cubit/cubit/garbage_route_cubit.dart';
import '../../../../logic/cubit/garbage_collected_cubit/garbage_collected_cubit.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../../../logic/cubit/targets_cubit/targets_cubit.dart';
import '../../auth/widgets/profile_view.dart';
import 'widgets/completed_view.dart';
import 'widgets/detail_card.dart';
import 'widgets/map_space.dart';

class DriverHomePage extends StatelessWidget {
  final AppUser appUser;
  const DriverHomePage({
    Key? key,
    required this.appUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TargetsCubit>(context).loadTargets();
    return page(
      Container(
        color: AppColors.light1,
        child: Column(
          children: [
            Container(
              color: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                children: [
                  Expanded(child: textL("home".tr(), 18, bold: true)),
                  hSpacer(5),
                  InkWell(
                    onTap: () => showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(5.w),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      builder: (sheetContext) {
                        return BlocProvider(
                            create: (context) => SignOutCubit(),
                            child: ProfileView(
                              appUser: appUser,
                            ));
                      },
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        Strings.user,
                        width: 10.w,
                        height: 10.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<TargetsCubit, TargetsState>(
                listener: (context, state) {
                  if (state is TargetsFailed) {
                    showSnackBar(context, state.errorMsg);
                  }
                },
                builder: (context, state) {
                  if (state is TargetsLoading) {
                    return Center(
                      child: viewSpinner(),
                    );
                  }
                  if (state is TargetsLoaded) {
                    return Column(
                      children: [
                        Expanded(
                          child: BlocProvider(
                            create: (context) => GarbageRouteCubit(),
                            child: MapSpace(
                              appUser: appUser,
                              startLocation: state.start,
                              endLocation: state.end,
                            ),
                          ),
                        ),
                        BlocProvider(
                          create: (context) => GarbageCollectedCubit(),
                          child: DetailCard(request: state.target),
                        )
                      ],
                    );
                  }
                  if (state is TargetsCompeted) {
                    return const CompletedView();
                  }
                  return nothing;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
