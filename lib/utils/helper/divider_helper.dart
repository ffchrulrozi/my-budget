import 'package:flutter/material.dart';

Widget h(num? scale) => SizedBox(width: (scale ?? 1) * 10);
Widget v(num? scale) => SizedBox(height: (scale ?? 1) * 10);
