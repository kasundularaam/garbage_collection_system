import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/components.dart';
import '../../../core/constants/strings.dart';
import '../../../core/themes/app_colors.dart';
import '../../router/app_router.dart';

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
        simpleAppBar("New Request", context),
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
                      textP("Garbage on my home", 16, bold: true),
                      // textP("මගේ නිවසේ කසල", 16, bold: true),
                      vSpacer(1),
                      const Divider(
                        color: AppColors.dark3,
                      ),
                      vSpacer(1),
                      Row(
                        children: [
                          Expanded(
                            child: text(
                                "Send request to collect garbage",
                                12,
                                // child: text("කසල එකතු කිරීම සදහා ඉල්ලීම් කරන්න", 12,

                                AppColors.dark3),
                          ),
                          hSpacer(5),
                          buttonFilledP("Request",
                              () => navPush(context, AppRouter.homeGarbagePage))
                          // buttonFilledP("ඉල්ලීම් කරන්න", () => {})
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
                      textP("Garbage on this location", 16, bold: true),
                      // textP("මෙම ස්ථනයේ ඇති කසල", 16, bold: true),
                      vSpacer(1),
                      const Divider(
                        color: AppColors.dark3,
                      ),
                      vSpacer(1),
                      Row(
                        children: [
                          Expanded(
                            child: text(
                                "Send request to collect garbage",
                                12,
                                // child: text("කසල එකතු කිරීම සදහා ඉල්ලීම් කරන්න", 12,
                                AppColors.dark3),
                          ),
                          hSpacer(5),
                          buttonFilledP("Request",
                              () => navPush(context, AppRouter.roadGarbagePage))
                          // buttonFilledP("ඉල්ලීම් කරන්න", () => {})
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
