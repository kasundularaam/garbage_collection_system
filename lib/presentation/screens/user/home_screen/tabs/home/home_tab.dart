// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/components/components.dart';
import '../../../../../../core/constants/strings.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../data/models/app_user.dart';
import '../../../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../../../../../logic/cubit/truck_map_cubit/truck_map_cubit.dart';
import 'widgets/sign_out_view.dart';
import 'widgets/trucks_map.dart';

class HomeTab extends StatefulWidget {
  final AppUser appUser;
  const HomeTab({
    Key? key,
    required this.appUser,
  }) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  AppUser get appUser => widget.appUser;
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
              create: (context) => TruckMapCubit(),
              child: const MapSample(),
            )),
          ],
        ));
  }
}
