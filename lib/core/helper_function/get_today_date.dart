(int day, int month, int year) get getTodayDate {
  final DateTime todayDate = DateTime.now();
  return (todayDate.day, todayDate.month, todayDate.year);
}
