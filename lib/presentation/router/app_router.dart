import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/exceptions/route_exception.dart';
import '../../data/models/app_user.dart';
import '../../logic/cubit/complain_cubit/complain_cubit.dart';
import '../../logic/cubit/complains_cubit/complains_cubit.dart';
import '../../logic/cubit/home_garbage_cubit/home_garbage_cubit.dart';
import '../../logic/cubit/landing_cubit/landing_cubit.dart';
import '../../logic/cubit/login_cubit/login_cubit.dart';
import '../../logic/cubit/register_cubit/register_cubit.dart';
import '../../logic/cubit/road_garbage_cubit/road_garbage_cubit.dart';
import '../../logic/cubit/send_request_cubit/send_request_cubit.dart';
import '../../logic/cubit/targets_cubit/targets_cubit.dart';
import '../screens/auth/login_screen/login_page.dart';
import '../screens/auth/register_screen/register_page.dart';
import '../screens/driver/home_screen/home_page.dart';
import '../screens/landing_screen/landing_page.dart';
import '../screens/user/complains_screen/complains_page.dart';
import '../screens/user/home_garbage_screen/home_garbage_page.dart';
import '../screens/user/home_screen/home_page.dart';
import '../screens/user/new_request_screen/new_request_page.dart';
import '../screens/user/road_garbage_screen/road_garbage_page.dart';
import '../screens/user_guid_screen/user_guid_page.dart';

class AppRouter {
  static const String landingPage = '/';
  static const String userHomePage = '/userHomePage';
  static const String driverHomePage = '/driverHomePage';
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';
  static const String newRequestPage = '/newRequestPage';
  static const String homeGarbagePage = '/homeGarbagePage';
  static const String roadGarbagePage = '/roadGarbagePage';
  static const String guidPage = '/guidPage';
  static const String complainsPage = '/complainsPage';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LandingCubit(),
            child: const LandingPage(),
          ),
        );
      case userHomePage:
        final AppUser appUser = settings.arguments as AppUser;
        return MaterialPageRoute(
          builder: (_) => UserHomePage(
            appUser: appUser,
          ),
        );
      case driverHomePage:
        final AppUser appUser = settings.arguments as AppUser;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TargetsCubit(),
            child: DriverHomePage(
              appUser: appUser,
            ),
          ),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginPage(),
          ),
        );
      case registerPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: const RegisterPage(),
          ),
        );
      case newRequestPage:
        return MaterialPageRoute(
          builder: (_) => const NewRequestPage(),
        );
      case homeGarbagePage:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HomeGarbageCubit(),
              ),
              BlocProvider(
                create: (context) => SendRequestCubit(),
              )
            ],
            child: const HomeGarbagePage(),
          ),
        );
      case roadGarbagePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RoadGarbageCubit(),
            child: const RoadGarbagePage(),
          ),
        );
      case guidPage:
        final String name = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => UserGuidPage(name: name),
        );
      case complainsPage:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ComplainCubit(),
              ),
              BlocProvider(
                create: (context) => ComplainsCubit(),
              ),
            ],
            child: ComplainsPage(
              reqId: args["reqId"],
              email: args["email"],
            ),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
