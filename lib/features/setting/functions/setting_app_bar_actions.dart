import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';

List<Widget> settingAppBarActions() {
  return [
    InkWell(
      onTap: () => (),
      child: Row(
        spacing: 10,
        children: [
          Text("EN"),
          Icon(
            FontAwesomeIcons.globe,
            size: 20,
          )
        ],
      ),
    ),
    h(2),
    Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(225, 225, 225, 1),
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.all(1),
          child: Row(
            children: [
              SunMoonBox(
                icon: Icons.sunny,
                color: Colors.orange,
                isActive: true,
              ),
              SunMoonBox(
                icon: FontAwesomeIcons.moon,
                color: Colors.blueGrey,
                isActive: false,
              ),
            ],
          ),
        ),
        h(1),
      ],
    )
  ];
}

class SunMoonBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isActive;
  const SunMoonBox({
    required this.icon,
    required this.color,
    required this.isActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: isActive ? color : null,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Icon(
        icon,
        size: 18,
        color: isActive ? Colors.white : color,
      ),
    );
  }
}
