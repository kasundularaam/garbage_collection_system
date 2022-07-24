// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/components.dart';
import '../../../core/constants/strings.dart';
import '../../../core/themes/app_colors.dart';
import '../../../logic/cubit/get_image_cubit/get_image_cubit.dart';

class CaptureCard extends StatefulWidget {
  final Function(File) onCaptured;
  const CaptureCard({
    Key? key,
    required this.onCaptured,
  }) : super(key: key);

  @override
  State<CaptureCard> createState() => _CaptureCardState();
}

class _CaptureCardState extends State<CaptureCard> {
  onCaptured(File image) => widget.onCaptured(image);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2.w),
              child: BlocConsumer<GetImageCubit, GetImageState>(
                listener: (context, state) {
                  log(state.toString());
                  if (state is GetImageFailed) {
                    showSnackBar(context, state.errorMsg);
                  }
                  if (state is GetImageLoaded) {
                    onCaptured(state.image);
                  }
                },
                builder: (context, state) {
                  if (state is GetImageLoading) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: viewSpinner(),
                      ),
                    );
                  }
                  if (state is GetImageLoaded) {
                    return Image.file(
                      state.image,
                      width: 100.w,
                      height: 25.h,
                      fit: BoxFit.cover,
                    );
                  }
                  return Image.asset(
                    Strings.capture,
                    width: 100.w,
                    height: 25.h,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            vSpacer(2),
            Row(
              children: [
                Expanded(
                  child: text("Capture garbage", 12, AppColors.dark3),
                ),
                hSpacer(5),
                buttonFilledP("Capture",
                    () => BlocProvider.of<GetImageCubit>(context).getImage())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
