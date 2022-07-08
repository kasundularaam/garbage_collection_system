import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import 'widgets/trucks_map.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.light1, child: const MapSample());
  }
}
