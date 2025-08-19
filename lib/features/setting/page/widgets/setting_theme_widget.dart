import 'package:flutter/material.dart';
import 'package:my_budget/features/setting/bloc/setting_bloc.dart';
import 'package:my_budget/features/setting/bloc/setting_event.dart';

class SettingThemeWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isActive;
  final SettingBloc bloc;

  const SettingThemeWidget({
    required this.icon,
    required this.color,
    required this.isActive,
    required this.bloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isActive) bloc.add(UpdateAppTheme());
      },
      child: Container(
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
      ),
    );
  }
}
