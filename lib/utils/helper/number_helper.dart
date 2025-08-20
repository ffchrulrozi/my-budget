import 'package:intl/intl.dart';

String Rupiah(int val) =>
    NumberFormat.currency(locale: "id", symbol: "Rp ", decimalDigits: 0)
        .format(val);

String Percent(double? val) =>
    val == null ? "0%" : "${(val * 100).toStringAsFixed(2)}%";
