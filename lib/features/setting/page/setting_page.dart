import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 100,
          child: Center(
            child: Text("Setting Top"),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Center(
              child: Text("Setting Body"),
            ),
          ),
        )
      ],
    );
  }
}

class TabItem {
  final String label;
  final IconData icon;

  TabItem(this.label, this.icon);
}
