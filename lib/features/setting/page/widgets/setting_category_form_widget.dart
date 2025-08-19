import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';

class SettingCategoryFormWidget extends StatelessWidget {
  final Category category;
  const SettingCategoryFormWidget({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(),
            ),
            child: Icon(
              IconData(category.icon),
              color: Colors.white,
              size: 28,
            ),
          ),
          h(1),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
              ),
              initialValue: category.name,
            ),
          ),
          h(1),
          Icon(FontAwesomeIcons.angleDown)
        ],
      ),
    );
  }
}