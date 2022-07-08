import 'package:flutter/material.dart';
import '../../../core/components/components.dart';
import '../../../core/themes/app_colors.dart';
import '../../../data/models/app_user.dart';
import 'tabs/home/home_tab.dart';
import 'tabs/profile_tab.dart';

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
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = [
    const HomeTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return bottomNavPage(
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
              Icons.person_rounded,
            ),
            label: "Profile",
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
    );
  }
}
