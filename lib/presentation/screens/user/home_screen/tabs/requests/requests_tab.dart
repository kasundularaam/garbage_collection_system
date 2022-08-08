import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/components/components.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../logic/cubit/requests_cubit/requests_cubit.dart';
import 'widgets/request_card.dart';

class RequestsTab extends StatefulWidget {
  const RequestsTab({Key? key}) : super(key: key);

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.light1,
        child: Column(
          children: [
            Container(
              color: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                children: [
                  Expanded(child: textL("Requests", 18, bold: true)),
                ],
              ),
            ),
            Expanded(
                child: BlocConsumer<RequestsCubit, RequestsState>(
              listener: (context, state) {
                if (state is RequestsFailed) {
                  showSnackBar(context, state.errorMsg);
                }
              },
              builder: (context, state) {
                if (state is RequestsLoading) {
                  return Center(
                    child: viewSpinner(),
                  );
                }
                if (state is RequestsLoaded) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    children: [
                      vSpacer(1),
                      ListView.builder(
                        itemCount: 5,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => RequestCard(
                            garbageRequest: state.garbageRequests[index]),
                      )
                    ],
                  );
                }
                return nothing;
              },
            )),
          ],
        ));
  }
}
