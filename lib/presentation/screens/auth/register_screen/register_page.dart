import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../logic/cubit/login_cubit/login_cubit.dart';
import '../../../router/app_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  login() {
    BlocProvider.of<LoginCubit>(context)
        .login(email: emailCtrl.text, password: passwordCtrl.text);
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
                child: textP("Register", 22, bold: true)),
            vSpacer(3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  inputPassword(nameCtrl, label: "Name"),
                  vSpacer(3),
                  inputEmail(emailCtrl, label: "Email"),
                  vSpacer(3),
                  inputPassword(passwordCtrl, label: "Password"),
                  vSpacer(3),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSucceed) {
                        navAndClear(context, AppRouter.landingPage);
                      }
                      if (state is LoginFailed) {
                        showSnackBar(context, state.errorMsg);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor),
                        );
                      }
                      return buttonFilledP("Register", () => login());
                    },
                  ),
                  vSpacer(5),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Do you have an account?",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: " Log In",
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
