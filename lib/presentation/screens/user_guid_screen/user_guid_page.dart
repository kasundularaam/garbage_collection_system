import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UserGuidPage extends StatefulWidget {
  final String name;
  const UserGuidPage({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<UserGuidPage> createState() => _UserGuidPageState();
}

class _UserGuidPageState extends State<UserGuidPage> {
  String get name => widget.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SfPdfViewer.asset('assets/PDFs/$name.pdf')),
    );
  }
}
