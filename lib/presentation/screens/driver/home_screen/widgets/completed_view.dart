import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/components/components.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../logic/cubit/targets_cubit/targets_cubit.dart';

class CompletedView extends StatelessWidget {
  const CompletedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        vSpacer(3),
        buttonTextP(
          "refresh".tr(),
          () => BlocProvider.of<TargetsCubit>(context).loadTargets(),
        ),
      ],
    );
  }
}
