import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../core/components/components.dart';
import '../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../data/models/garbage_request.dart';

class RequestCard extends StatefulWidget {
  final GarbageRequest garbageRequest;
  const RequestCard({
    Key? key,
    required this.garbageRequest,
  }) : super(key: key);

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  GarbageRequest get garbageRequest => widget.garbageRequest;
  bool get collected => garbageRequest.status == "COLLECTED";
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textP("Garbage on ${garbageRequest.location}", 16, bold: true),
            vSpacer(2),
            text("Type: ${garbageRequest.garbageType}", 14, AppColors.dark3),
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
                        ? text("Collected", 14, bold: true, AppColors.collected)
                        : text("Pending", 14, bold: true, AppColors.pending),
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
            )
          ],
        ),
      ),
    );
  }
}
