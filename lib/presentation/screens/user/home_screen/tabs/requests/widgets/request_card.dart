// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../core/components/components.dart';
import '../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../data/models/garbage_request.dart';
import '../../../../../../router/app_router.dart';

class RequestCard extends StatelessWidget {
  final GarbageRequest request;
  final String email;
  const RequestCard({
    Key? key,
    required this.request,
    required this.email,
  }) : super(key: key);

  bool get collected => request.status == "COLLECTED";

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textP(
                "garbage_location"
                    .tr(namedArgs: {"location": request.location.tr()}),
                16,
                bold: true),
            vSpacer(2),
            text("garbage_type".tr(namedArgs: {"type": request.garbageType}),
                14, AppColors.dark3),
            vSpacer(2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                  color:
                      collected ? AppColors.collectedBg : AppColors.pendingBg,
                  borderRadius: BorderRadius.circular(1.w)),
              child: Row(
                children: [
                  Expanded(
                    child: collected
                        ? text(
                            "collected".tr(),
                            14,
                            bold: true,
                            AppColors.collected)
                        : text(
                            "pending".tr(), 14, bold: true, AppColors.pending),
                  ),
                  collected
                      ? Icon(
                          Icons.check_circle_rounded,
                          size: 22.sp,
                          color: AppColors.collected,
                        )
                      : Icon(
                          Icons.pending_rounded,
                          size: 22.sp,
                          color: AppColors.pending,
                        )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(child: nothing),
                buttonTextP(
                  "complaints".tr(),
                  () => navPush(context, AppRouter.complainsPage,
                      args: {"reqId": "${request.id}", "email": email}),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
