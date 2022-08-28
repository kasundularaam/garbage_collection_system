import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/app_user.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../../router/app_router.dart';

class ProfileView extends StatelessWidget {
  final AppUser appUser;
  const ProfileView({
    Key? key,
    required this.appUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.asset(
              Strings.user,
              width: 30.w,
              height: 30.w,
            ),
          ),
          vSpacer(2),
          textD(appUser.username, 16, bold: true),
          vSpacer(1),
          textD(appUser.email, 14),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
            child: const Divider(
              color: AppColors.dark1,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textD("NIC2".tr(), 14),
              vSpacer(1),
              Expanded(
                child: textD(appUser.nic, 14),
              ),
            ],
          ),
          vSpacer(1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textD("mobile2".tr(), 14),
              vSpacer(2),
              Expanded(
                child: textD("${appUser.mobileNo}", 14),
              ),
            ],
          ),
          vSpacer(1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textD("address2".tr(), 14),
              vSpacer(2),
              Expanded(
                child: textD(appUser.address, 14),
              ),
            ],
          ),
          vSpacer(1),
          const Divider(
            color: AppColors.dark1,
          ),
          vSpacer(1),
          textD("app_language".tr(), 14, bold: true),
          vSpacer(1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonTextP(
                "English",
                () => context.setLocale(const Locale('en')),
              ),
              buttonTextP(
                "සිංහල",
                () => context.setLocale(const Locale('si')),
              )
            ],
          ),
          vSpacer(1),
          const Divider(
            color: AppColors.dark1,
          ),
          vSpacer(1),
          textD("user_guide".tr(), 14, bold: true),
          vSpacer(1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonTextP(
                "English",
                () => navPush(context, AppRouter.guidPage, args: "english"),
              ),
              buttonTextP(
                "සිංහල",
                () => navPush(context, AppRouter.guidPage, args: "sinhala"),
              )
            ],
          ),
          vSpacer(1),
          const Divider(
            color: AppColors.dark1,
          ),
          vSpacer(1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: textD("remove_account".tr(), 14),
              ),
              hSpacer(2),
              BlocConsumer<SignOutCubit, SignOutState>(
                listener: (context, state) {
                  if (state is SignOutFailed) {
                    showSnackBar(context, state.errorMsg);
                  }
                  if (state is SignOutSucceed) {
                    navAndClear(context, AppRouter.landingPage);
                  }
                },
                builder: (context, state) {
                  return buttonFilledP(
                    "sign_out".tr(),
                    () => BlocProvider.of<SignOutCubit>(context).signOut(),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
