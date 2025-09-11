import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/tafsir_content.dart';

class EditTafsir extends StatelessWidget {
  const EditTafsir({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TafsirEditCubit()..loadTafsir(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text('تحرير التفسير'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: TafsirContent(),
        ),
      ),
    );
  }
}
