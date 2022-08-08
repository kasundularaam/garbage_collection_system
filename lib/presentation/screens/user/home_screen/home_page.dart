import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/components.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/app_user.dart';
import '../../../../logic/cubit/requests_cubit/requests_cubit.dart';
import '../../../router/app_router.dart';
import 'tabs/home/home_tab.dart';
import 'tabs/requests/requests_tab.dart';

class HomePage extends StatefulWidget {
  final AppUser appUser;
  const HomePage({
    Key? key,
    required this.appUser,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppUser get appUser => widget.appUser;
  int _selectedIndex = 0;
  static HomeTab? homeTab;

  @override
  void initState() {
    super.initState();
    homeTab = HomeTab(appUser: appUser);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = [
    homeTab!,
    BlocProvider(
      create: (context) => RequestsCubit(),
      child: const RequestsTab(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      _widgetOptions.elementAt(_selectedIndex),
      BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: "Home",
            backgroundColor: AppColors.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_rounded,
            ),
            label: "Requests",
            backgroundColor: AppColors.primaryColor,
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.light0,
        unselectedItemColor: AppColors.light0.withOpacity(0.7),
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5,
      ),
      fab: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () => navPush(context, AppRouter.newRequestPage),
              label: textL("Request", 14),
              icon: const Icon(
                Icons.add_rounded,
                color: AppColors.light0,
              ),
            )
          : null,
    );
  }
}
