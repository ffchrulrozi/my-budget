import 'package:flutter/material.dart';

class Item {
  final String type;
  final IconData icon;
  final String title;
  final String desc;
  final int amount;
  final double percent;

  Item({
    required this.type,
    required this.icon,
    required this.title,
    required this.desc,
    required this.amount,
    required this.percent,
  });
}

class ItemType{
  static String INCOME = "INCOME";
  static String OUTCOME = "OUTCOME";
}