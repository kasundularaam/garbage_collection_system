import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/components/components.dart';
import '../../../../../core/themes/app_colors.dart';

class RequestsTab extends StatefulWidget {
  const RequestsTab({Key? key}) : super(key: key);

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.light1,
        child: Column(
          children: [
            Container(
              color: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                children: [
                  Expanded(child: textL("Requests", 18, bold: true)),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              children: [
                vSpacer(1),
                ListView.builder(
                  itemCount: 5,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textP("Garbage on my home", 16, bold: true),
                          vSpacer(2),
                          text("Requested on: 7/9/2022 at: 12:45", 14,
                              AppColors.dark3),
                          vSpacer(2),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.h),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(1.w)),
                            child: Center(
                                child:
                                    textL("Garbage Collected", 12, bold: true)),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
          ],
        ));
  }
}
