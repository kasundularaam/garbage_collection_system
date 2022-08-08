// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textP("Garbage on my home", 16, bold: true),
            vSpacer(2),
            text("Requested on: 7/9/2022 at: 12:45", 14, AppColors.dark3),
            vSpacer(2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(1.w)),
              child: Center(child: textL("Garbage Collected", 12, bold: true)),
            )
          ],
        ),
      ),
    );
  }
}
