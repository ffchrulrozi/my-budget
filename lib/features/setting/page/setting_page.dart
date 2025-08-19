import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_budget/features/setting/bloc/setting_bloc.dart';
import 'package:my_budget/features/dashboard/models/dashboard_page_setting.dart';
import 'package:my_budget/features/setting/bloc/setting_event.dart';
import 'package:my_budget/features/setting/models/setting.dart';
import 'package:my_budget/features/setting/page/widgets/setting_category_form_widget.dart';
import 'package:my_budget/features/setting/page/widgets/setting_theme_widget.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';

class SettingPage extends StatelessWidget {
  final DashboardPageSetting pageSetting;
  const SettingPage({required this.pageSetting, super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        pageSetting.isThemeLight ? pageSetting.color : Colors.black;
    final bloc = context.watch<SettingBloc>();
    final state = bloc.state;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Icon(pageSetting.icon),
        title: Text(pageSetting.title),
        titleSpacing: 0,
        actions: [
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
                    SettingThemeWidget(
                      icon: Icons.sunny,
                      color: Colors.orange,
                      isActive: state.appTheme == APP_THEME.LIGHT,
                      bloc: bloc,
                    ),
                    SettingThemeWidget(
                      icon: FontAwesomeIcons.moon,
                      color: Colors.blueGrey,
                      isActive: state.appTheme == APP_THEME.DARK,
                      bloc: bloc,
                    ),
                  ],
                ),
              ),
              h(1),
            ],
          )
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Monthly limit", style: text(context).titleSmall),
                if (state.monthlyLimit != null)
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      prefixText: "Rp ",
                    ),
                    initialValue: state.monthlyLimit.toString(),
                  ),
                v(1),
                Divider(),
                Row(children: [
                  Text("Categories", style: text(context).titleSmall),
                  Spacer(),
                  Expanded(
                    child: FormBuilderDropdown<int>(
                      name: 'type',
                      initialValue:
                          state.types.isEmpty ? null : state.types[0].id,
                      items: state.types
                          .map((type) => DropdownMenuItem(
                              value: type.id, child: Text(type.name)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          bloc.add(ChangeCategoryType(val));
                        }
                      },
                    ),
                  ),
                  h(1),
                ]),
                v(1),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) => SettingCategoryFormWidget(
                    category: state.categories[index],
                    key: ValueKey(state.categories[index].id),
                  ),
                ),
                Row(children: [
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Row(children: [
                      Icon(Icons.add, color: Colors.white),
                      h(1),
                      Text(
                        "Add Category",
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                  )
                ]),
                v(5),
                Center(
                  child: InkWell(
                    onTap: () => (),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor,
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
