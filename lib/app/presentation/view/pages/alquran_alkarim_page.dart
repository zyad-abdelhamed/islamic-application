import 'package:flutter/material.dart';
import 'package:test_app/app/presentation/view/components/index_widget.dart';
import 'package:test_app/app/presentation/view/components/pages_app_bar.dart';

class AlquranAlkarimPage extends StatelessWidget {
  const AlquranAlkarimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: pagesAppBar[0],
      body: IndexWidget(),
    );
  }
}