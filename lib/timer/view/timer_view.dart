// import 'package:dummy/timer/cubit/timer_cubit.dart';
// import 'package:dummy/timer/cubit/timer_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class TimerView extends StatelessWidget {
//   const TimerView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TimerCubit(),
//       child: BlocBuilder<TimerCubit, TimerState>(
//         builder: (context, state) {
//           return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "${state.hours.toString().padLeft(2, '0')}:"
//           "${state.minutes.toString().padLeft(2, '0')}:"
//           "${state.seconds.toString().padLeft(2, '0')}",
//           style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 context.read<TimerCubit>().startTimerFromString("01:30:00"); // مثال: يبدأ العد التنازلي من دقيقة و30 ثانية
//               },
//               child: const Text("ابدأ"),
//             ),
//             const SizedBox(width: 10),
//             ElevatedButton(
//               onPressed: () {
//                 context.read<TimerCubit>().stopTimer();
//               },
//               child: const Text("إيقاف"),
//             ),
//             const SizedBox(width: 10),
//             ElevatedButton(
//               onPressed: () {
//                 context.read<TimerCubit>().resetTimer();
//               },
//               child: const Text("إعادة ضبط"),
//             ),
//           ],
//         ),
//       ],
//     );
//         },
//       ),
//     );
//   }
// }
