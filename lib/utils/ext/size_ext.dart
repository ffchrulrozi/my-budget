import 'package:flutter/material.dart';

extension SizeExt on num {
  double w(BuildContext context) =>
      (this / 100) * MediaQuery.sizeOf(context).width;

  double h(BuildContext context) =>
      (this / 100) * MediaQuery.sizeOf(context).height;
}
