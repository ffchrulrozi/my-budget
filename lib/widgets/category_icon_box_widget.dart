import 'package:flutter/material.dart';

class CategoryIconBoxWidget extends StatelessWidget {
  final Color color;
  final int icon;
  const CategoryIconBoxWidget(this.icon, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(2),
      child: Icon(
        IconData(
          icon,
          fontFamily: 'MaterialIcons',
        ),
        size: 28,
      ),
    );
  }
}
