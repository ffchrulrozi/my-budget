import 'package:flutter/material.dart';

extension SizeExt on num {
  double w(BuildContext context) =>
      (this / 100) * MediaQuery.sizeOf(context).width;

  double h(BuildContext context) =>
      (this / 100) * MediaQuery.sizeOf(context).height;

  double hBody(BuildContext context) {
    final appBarHeight = Scaffold.of(context).appBarMaxHeight ?? kToolbarHeight;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomBarHeight = MediaQuery.of(context).padding.bottom;

    final bodyHeight =
        screenHeight - appBarHeight - statusBarHeight - bottomBarHeight;
    return (this / 100) * bodyHeight;
  }
}
