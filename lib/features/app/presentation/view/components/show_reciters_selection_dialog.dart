// import 'package:flutter/material.dart';
// import 'package:test_app/core/theme/app_colors.dart';
// import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
// import 'reciter_check_tile.dart';

// Future<void> showRecitersSelectionDialog({
//   required BuildContext context,
//   required List<ReciterEntity> reciters,
//   required Function(List<ReciterEntity>) onConfirm,
// }) async {
//   await showDialog(
//     context: context,
//     builder: (_) {
//       final Color backgroundColor =
//           Theme.of(context).brightness == Brightness.dark
//               ? Colors.black
//               : Colors.white;

//       return AlertDialog.adaptive(
//         backgroundColor: backgroundColor,
//         title: Text(
//           "اختر الشيوخ",
//           style: TextStyle(
//               color: AppColors.primaryColor, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.center,
//         ),
//         content: ValueListenableBuilder<List<ReciterEntity>>(
//           valueListenable: selectedReciters,
//           builder: (context, selected, _) {
//             return ListView.separated(
//               itemCount: reciters.length,
//               separatorBuilder: (context, index) => const Divider(),
//               itemBuilder: (context, index) {
//                 final reciter = reciters[index];
//                 final isSelected = selected.contains(reciter);

//                 return ReciterCheckTile(
//                   reciter: reciter,
//                   isSelected: isSelected,
//                   onChanged: (value) {
//                     final updated = List<ReciterEntity>.from(selected);
//                     if (value == true) {
//                       updated.add(reciter);
//                     } else {
//                       updated.remove(reciter);
//                     }
//                     selectedReciters.value = updated;
//                   },
//                 );
//               },
//             );
//           },
//         ),
//         actionsAlignment: MainAxisAlignment.center,
//         actions: [
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primaryColor,
//               foregroundColor: backgroundColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(50),
//               ),
//             ),
//             onPressed: () {
//               onConfirm(selectedReciters.value);
//               Navigator.pop(context);
//             },
//             child: const Text("تأكيد"),
//           ),
//         ],
//       );
//     },
//   );
// }
