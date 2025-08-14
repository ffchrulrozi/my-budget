extension DateExt on DateTime {
  DateTime toStartOfDay() => DateTime(year, month, day);
  DateTime toEndOfDay() => DateTime(year, month, day, 23, 59, 59);
  DateTime toStartOfMonth() => DateTime(year, month, 1, 0, 0, 0);
}
