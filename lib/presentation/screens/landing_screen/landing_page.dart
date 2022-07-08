import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/components.dart';
import '../../../core/constants/strings.dart';
import '../../../logic/cubit/landing_cubit/landing_cubit.dart';
import '../../router/app_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LandingCubit>(context).loadApp();
    return BlocListener<LandingCubit, LandingState>(
      listener: (context, state) {
        if (state is LandingFailed) {
          showSnackBar(context, state.errorMsg);
        }
        if (state is LandingToAuth) {
          navAndClear(context, AppRouter.loginPage);
        }
        if (state is LandingToHome) {
          navAndClear(context, AppRouter.homePage, args: state.appUser);
        }
      },
      child: page(
        Center(
          child: textP(Strings.appTitle, 22, bold: true),
        ),
      ),
    );
  }
}
