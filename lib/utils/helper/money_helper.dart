import 'package:intl/intl.dart';

String Rupiah(int number)=>NumberFormat.currency(locale: "id", symbol: "Rp ", decimalDigits: 0).format(number);