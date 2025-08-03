// import 'package:flutter/material.dart';
// import 'package:test_app/core/widgets/app_sneak_bar.dart';
// import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
// import 'package:test_app/features/app/domain/usecases/get_surah_with_tafsir_use_case.dart';
// import 'package:test_app/features/app/presentation/view/pages/tafsier_page.dart';

// class GetSurahWithTafsirController {
//   final GetSurahWithTafsirUseCase _getSurahWithTafsirUseCase;
//   GetSurahWithTafsirController(
//       {required GetSurahWithTafsirUseCase getSurahWithTafsirUseCase})
//       : _getSurahWithTafsirUseCase = getSurahWithTafsirUseCase;
//   void _showErrorMessage(BuildContext context, String message) {
//     appSneakBar(context: context, message: message, isError: true);
//   }

//   void getSurahWithTafsir(BuildContext context, ValueNotifier<bool> isLoading,
//       TafsirRequestParams params) async {
//     final result = await _getSurahWithTafsirUseCase.call(parameters: params);
//     result.fold(
//       (failure) {
//         _showErrorMessage(context, failure.message);
//         isLoading.value = false;
//       },
//       (r) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => TafsirPage(
//               surahName: params.surahName,
//               ayahsWithTafsir: r,
//             ),
//           ),
//         );
//         isLoading.value = false;
//       },
//     );
//   }
// }
