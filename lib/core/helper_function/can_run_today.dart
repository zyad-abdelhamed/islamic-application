// import 'package:intl/intl.dart';

// Future<bool> canRunToday() async {
//   final prefs = await SharedPreferences.getInstance();
//   final now = DateTime.now();
//   final today = DateFormat('yyyy-MM-dd').format(now);

//   final lastRunDate = prefs.getString('lastRunDate');

//   if (lastRunDate != today) {
//     // تحديث التاريخ
//     await prefs.setString('lastRunDate', today);
//     return true; // يمكن التنفيذ
//   }

//   return false; // تم التنفيذ اليوم مسبقاً
// }


