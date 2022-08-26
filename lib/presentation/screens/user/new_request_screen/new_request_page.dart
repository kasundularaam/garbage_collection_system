import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../router/app_router.dart';

class NewRequestPage extends StatefulWidget {
  const NewRequestPage({Key? key}) : super(key: key);

  @override
  State<NewRequestPage> createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  @override
  Widget build(BuildContext context) {
    return page(Column(
      children: [
        simpleAppBar("new_request".tr(), context),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              vSpacer(2),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2.w),
                        child: Image.asset(
                          Strings.home,
                          width: 100.w,
                          height: 20.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      vSpacer(2),
                      textP("home_garbage".tr(), 16, bold: true),
                      vSpacer(1),
                      const Divider(
                        color: AppColors.dark3,
                      ),
                      vSpacer(1),
                      Row(
                        children: [
                          Expanded(
                            child:
                                text("send_request".tr(), 12, AppColors.dark3),
                          ),
                          hSpacer(5),
                          buttonFilledP("request".tr(),
                              () => navPush(context, AppRouter.homeGarbagePage))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2.w),
                        child: Image.asset(
                          Strings.road,
                          width: 100.w,
                          height: 20.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      vSpacer(2),
                      textP("road_garbage".tr(), 16, bold: true),
                      vSpacer(1),
                      const Divider(
                        color: AppColors.dark3,
                      ),
                      vSpacer(1),
                      Row(
                        children: [
                          Expanded(
                            child:
                                text("send_request".tr(), 12, AppColors.dark3),
                          ),
                          hSpacer(5),
                          buttonFilledP("request".tr(),
                              () => navPush(context, AppRouter.roadGarbagePage))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              vSpacer(2),
            ],
          ),
        )
      ],
    ));
  }
}
