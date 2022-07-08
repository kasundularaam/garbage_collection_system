import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_colors.dart';

class AppTextStyles {
  // h1

  static TextStyle h1(Color color) =>
      TextStyle(color: color, fontSize: 18.sp, fontWeight: FontWeight.bold);

  static TextStyle h1Primary = TextStyle(
      color: AppColors.primaryColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold);

  static TextStyle h1Light = TextStyle(
      color: AppColors.light0, fontSize: 18.sp, fontWeight: FontWeight.bold);

  static TextStyle h1Dark = TextStyle(
      color: AppColors.dark0, fontSize: 18.sp, fontWeight: FontWeight.bold);

  // h2

  static TextStyle h2(Color color) =>
      TextStyle(color: color, fontSize: 14.sp, fontWeight: FontWeight.bold);

  static TextStyle h2Primary = TextStyle(
      color: AppColors.primaryColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold);

  static TextStyle h2Light = TextStyle(
      color: AppColors.light0, fontSize: 14.sp, fontWeight: FontWeight.bold);

  static TextStyle h2Dark = TextStyle(
      color: AppColors.dark0, fontSize: 14.sp, fontWeight: FontWeight.bold);

  // h3

  static TextStyle h3(Color color) =>
      TextStyle(color: color, fontSize: 12.sp, fontWeight: FontWeight.bold);

  static TextStyle h3Primary = TextStyle(
      color: AppColors.primaryColor,
      fontSize: 12.sp,
      fontWeight: FontWeight.bold);

  static TextStyle h3Light = TextStyle(
      color: AppColors.light0, fontSize: 12.sp, fontWeight: FontWeight.bold);

  static TextStyle h3Dark = TextStyle(
      color: AppColors.dark0, fontSize: 12.sp, fontWeight: FontWeight.bold);

  // p1

  static TextStyle p1(Color color) => TextStyle(
        color: color,
        fontSize: 14.sp,
      );

  static TextStyle p1Primary = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 14.sp,
  );

  static TextStyle p1Light = TextStyle(
    color: AppColors.light0,
    fontSize: 14.sp,
  );

  static TextStyle p1Dark = TextStyle(
    color: AppColors.dark0,
    fontSize: 14.sp,
  );

  // p2

  static TextStyle p2(Color color) => TextStyle(
        color: color,
        fontSize: 12.sp,
      );

  static TextStyle p2Primary = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 12.sp,
  );

  static TextStyle p2Light = TextStyle(
    color: AppColors.light0,
    fontSize: 12.sp,
  );

  static TextStyle p2Dark = TextStyle(
    color: AppColors.dark0,
    fontSize: 12.sp,
  );

  // p3

  static TextStyle p3(Color color) => TextStyle(
        color: color,
        fontSize: 10.sp,
      );

  static TextStyle p3Primary = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 10.sp,
  );

  static TextStyle p3Light = TextStyle(
    color: AppColors.light0,
    fontSize: 10.sp,
  );

  static TextStyle p3Dark = TextStyle(
    color: AppColors.dark0,
    fontSize: 10.sp,
  );
}
