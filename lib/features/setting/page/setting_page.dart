import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_budget/data/models/category.dart';
import 'package:my_budget/features/dashboard/models/dashboard_page_setting.dart';
import 'package:my_budget/features/setting/models/setting.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';

class SettingPage extends StatelessWidget {
  final DashboardPageSetting pageSetting;
  const SettingPage({required this.pageSetting, super.key});

  @override
  Widget build(BuildContext context) {
    var setting = Setting(
      language: "EN",
      isAppBgLight: true,
      monthlyLimit: 2000000,
      categories: <Category>[
        Category(
          label: "Transportation",
          icon: Icons.motorcycle,
          color: Colors.teal,
        ),
        Category(
          label: "Food",
          icon: Icons.food_bank_outlined,
          color: Colors.pink,
        ),
        Category(
          label: "Data Package",
          icon: Icons.wifi,
          color: Colors.orange,
        ),
        Category(
          label: "Monthly Needs",
          icon: Icons.home_work_outlined,
          color: Colors.purpleAccent,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: pageSetting.color,
      appBar: AppBar(
        backgroundColor: pageSetting.color,
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
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    prefixText: "Rp ",
                  ),
                  initialValue: setting.monthlyLimit.toString(),
                ),
                v(1),
                Divider(),
                Text("Categories", style: text(context).titleSmall),
                v(1),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: setting.categories?.length,
                  itemBuilder: (context, index) {
                    var category = setting.categories![index];

                    return CategoryForm(category: category);
                  },
                ),
                Row(children: [
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: pageSetting.color,
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
                // CategoryForm(),
                v(3),
                Center(
                  child: InkWell(
                    onTap: () => (),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: pageSetting.color),
                        borderRadius: BorderRadius.circular(10),
                        color: pageSetting.color,
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

class CategoryForm extends StatelessWidget {
  final Category? category;
  const CategoryForm({this.category, super.key});

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
              border: Border.all(color: category?.color ?? Colors.black),
              color: category?.color,
            ),
            child: Icon(
              category?.icon,
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
              initialValue: category?.label,
            ),
          )
        ],
      ),
    );
  }
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
