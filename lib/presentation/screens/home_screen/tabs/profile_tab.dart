import 'package:flutter/material.dart';

import '../../../../core/components/components.dart';
import '../../../../core/themes/app_colors.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.light1,
      child: Center(
        child: textP("Profile Tab", 14),
      ),
    );
  }
}
