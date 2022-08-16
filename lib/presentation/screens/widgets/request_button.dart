// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/components.dart';
import '../../../data/models/garbage_request_req.dart';
import '../../../logic/cubit/send_request_cubit/send_request_cubit.dart';

class RequestButton extends StatefulWidget {
  final GarbageRequestReq request;
  const RequestButton({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  State<RequestButton> createState() => _RequestButtonState();
}

class _RequestButtonState extends State<RequestButton> {
  GarbageRequestReq get request => widget.request;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendRequestCubit, SendRequestState>(
      listener: (context, state) {
        if (state is SendRequestFailed) {
          showSnackBar(context, state.errorMsg);
        }
        if (state is SendRequestSent) {
          showSnackBar(context, "Request Sent!");
        }
      },
      builder: (context, state) {
        if (state is SendRequestSending) {
          return Center(child: viewSpinner());
        }
        return buttonFilledP(
          "Send Request",
          () => BlocProvider.of<SendRequestCubit>(context)
              .sendRequest(request: request),
        );
      },
    );
  }
}
