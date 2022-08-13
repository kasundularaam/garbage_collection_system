import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_collection_system/logic/cubit/garbage_map_cubit/garbage_map_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/app_user.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../../../logic/cubit/truck_map_cubit/truck_map_cubit.dart';
import '../../auth/widgets/sign_out_view.dart';
import 'widgets/garbage_map.dart';

class DriverHomePage extends StatefulWidget {
  final AppUser appUser;
  const DriverHomePage({
    Key? key,
    required this.appUser,
  }) : super(key: key);

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  AppUser get appUser => widget.appUser;

  @override
  Widget build(BuildContext context) {
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
                  Expanded(child: textL("Home", 18, bold: true)),
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
                            child: SignOutView(
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
              child: BlocProvider(
                create: (context) => GarbageMapCubit(),
                child: const GarbageMap(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
