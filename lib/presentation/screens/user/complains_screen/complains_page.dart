import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/complain_req.dart';
import '../../../../logic/cubit/complain_cubit/complain_cubit.dart';
import '../../../../logic/cubit/complains_cubit/complains_cubit.dart';

class ComplainsPage extends StatelessWidget {
  final String reqId;
  final String email;
  ComplainsPage({
    Key? key,
    required this.reqId,
    required this.email,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ComplainsCubit>(context).loadComplains(reqId: reqId);
    return page(
      Column(
        children: [
          simpleAppBar("complaints".tr(), context),
          Expanded(
            child: BlocConsumer<ComplainsCubit, ComplainsState>(
              listener: (context, state) {
                if (state is ComplainsFailed) {
                  showSnackBar(context, state.errorMsg);
                }
              },
              builder: (context, state) {
                if (state is ComplainsLoading) {
                  return Center(
                    child: viewSpinner(),
                  );
                }
                if (state is ComplainsLoaded) {
                  return ListView.builder(
                    itemCount: state.complains.length,
                    physics: const BouncingScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    itemBuilder: (context, index) => Card(
                      color: AppColors.light0,
                      child: Container(
                        color: AppColors.complainBg,
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: textD(state.complains[index].detail, 14),
                        ),
                      ),
                    ),
                  );
                }
                return nothing;
              },
            ),
          ),
          Container(
            color: AppColors.light0,
            padding: EdgeInsets.all(3.w),
            child: Row(
              children: [
                Expanded(
                  child: inputText(
                    controller,
                    hint: "complaint".tr(),
                  ),
                ),
                BlocConsumer<ComplainCubit, ComplainState>(
                  listener: (context, state) {
                    if (state is ComplainFailed) {
                      showSnackBar(context, state.errorMsg);
                    }
                    if (state is ComplainSent) {
                      controller.clear();
                      BlocProvider.of<ComplainsCubit>(context)
                          .loadComplains(reqId: reqId);
                    }
                  },
                  builder: (context, state) {
                    if (state is ComplainSending) {
                      return buttonTextP("sending".tr(), () => {});
                    }
                    return buttonTextP(
                      "send".tr(),
                      () => BlocProvider.of<ComplainCubit>(context).send(
                        complainReq: ComplainReq(
                          reqId: reqId,
                          email: email,
                          detail: controller.text,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
