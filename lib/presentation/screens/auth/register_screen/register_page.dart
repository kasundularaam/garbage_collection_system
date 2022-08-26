import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/register_req.dart';
import '../../../../logic/cubit/register_cubit/register_cubit.dart';
import '../../../router/app_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController nicCtrl = TextEditingController();

  register() {
    BlocProvider.of<RegisterCubit>(context).register(
        registerReq: RegisterReq(
            username: usernameCtrl.text,
            mobileNo: int.parse(mobileCtrl.text),
            email: emailCtrl.text,
            address: addressCtrl.text,
            password: passwordCtrl.text,
            nic: nicCtrl.text,
            type: "USER"));
  }

  @override
  Widget build(BuildContext context) {
    return page(
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSpacer(2),
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                Strings.landing,
                height: 25.h,
                fit: BoxFit.fitWidth,
              ),
            ),
            vSpacer(5),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: textP("register".tr(), 22, bold: true)),
            vSpacer(3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  inputName(usernameCtrl, label: "username".tr()),
                  vSpacer(3),
                  inputEmail(emailCtrl, label: "email".tr()),
                  vSpacer(3),
                  inputText(addressCtrl, label: "address".tr()),
                  vSpacer(3),
                  inputPhone(mobileCtrl, label: "mobile".tr()),
                  vSpacer(3),
                  inputText(nicCtrl, label: "NIC".tr()),
                  vSpacer(3),
                  inputPassword(passwordCtrl, label: "password".tr()),
                  vSpacer(3),
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSucceed) {
                        navAndClear(context, AppRouter.landingPage);
                      }
                      if (state is RegisterFailed) {
                        showSnackBar(context, state.errorMsg);
                      }
                    },
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor),
                        );
                      }
                      return buttonFilledP("register".tr(), () => register());
                    },
                  ),
                  vSpacer(5),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "have_account".tr(),
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "login2".tr(),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => navAndClear(context, AppRouter.loginPage),
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                  vSpacer(5)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
