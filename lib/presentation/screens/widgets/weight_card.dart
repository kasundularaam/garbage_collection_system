import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/components.dart';
import '../../../core/themes/app_colors.dart';

class WeightCard extends StatefulWidget {
  final Function(int) onChange;
  const WeightCard({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<WeightCard> createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  int weight = 0;
  onChange() => widget.onChange(weight);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textD("weight_approximately".tr(), 16, bold: true),
            vSpacer(3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    if (weight > 0) {
                      weight--;
                    }
                  }),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: const BoxDecoration(
                        color: AppColors.light1, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      color: AppColors.primaryColor,
                      size: 28.sp,
                    ),
                  ),
                ),
                hSpacer(3),
                Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor, shape: BoxShape.circle),
                    child: textL("${weight}Kg", 18, bold: true)),
                hSpacer(3),
                GestureDetector(
                  onTap: () => setState(() {
                    weight++;
                  }),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: const BoxDecoration(
                        color: AppColors.light1, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: AppColors.primaryColor,
                      size: 28.sp,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
