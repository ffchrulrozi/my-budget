import 'package:intl/intl.dart';

String Rupiah(double number) =>
    NumberFormat.currency(locale: "id", symbol: "Rp ", decimalDigits: 0)
        .format(number);
String Percent(double number) =>
    NumberFormat.percentPattern("id").format(number / 100);
