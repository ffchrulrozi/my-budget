import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_budget/features/dashboard/models/dashboard_page_setting.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_bloc.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_event.dart';
import 'package:my_budget/features/transaction/list/page/widgets/transaction_list_item_box_widget.dart';
import 'package:my_budget/routes/paths.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';
import 'package:my_budget/utils/helper/number_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';

class TransactionListPage extends StatelessWidget {
  final DashboardPageSetting pageSetting;
  const TransactionListPage({required this.pageSetting, super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        pageSetting.isThemeLight ? pageSetting.color : Colors.black;

    final bloc = context.watch<TransactionListBloc>();
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
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: state.filter?.date,
                firstDate: DateTime(2021),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                bloc.add(FilterChange(date: pickedDate));
              }
            },
            child: Row(
              children: [
                Text(state.filter?.date == null
                    ? ""
                    : DateFormat("dd MMM yyyy").format(state.filter!.date!)),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          h(2),
          DropdownButton<int>(
            alignment: Alignment.centerRight,
            value: state.filter?.typeId,
            style: TextStyle(textBaseline: TextBaseline.alphabetic),
            iconEnabledColor: Colors.white,
            underline: Container(),
            items: state.types
                .map(
                  (option) => DropdownMenuItem(
                    value: option.id,
                    child: Text(
                      option.name.tr(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
                .toList(),
            onChanged: (val) => bloc.add(FilterChange(typeId: val)),
            selectedItemBuilder: (context) => state.types
                .map(
                  (option) => DropdownMenuItem(
                    value: option.id,
                    child: Text(
                      option.name.tr(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
                .toList(),
          ),
          h(1),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => bloc.add(LoadTransactions()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopBox(
                    label: "incomeAmount".tr(),
                    value: state.summary?.income ?? 0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  TopBox(
                    label: "outcomeAmount".tr(),
                    value: state.summary?.outcome ?? 0,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                ],
              ),
            ),
            Expanded(child: ItemBoxWidget(bloc, state, pageSetting)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => context.push(Paths.TRANSACTION_ADD),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TabItem {
  final String label;
  final IconData icon;

  TabItem(this.label, this.icon);
}

class TopBox extends StatelessWidget {
  final String label;
  final int value;
  final CrossAxisAlignment crossAxisAlignment;
  const TopBox(
      {required this.label,
      required this.value,
      required this.crossAxisAlignment,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: text(context).bodyMedium!.copyWith(color: Colors.white),
        ),
        Text(
          Rupiah(value),
          style: text(context).titleLarge!.copyWith(color: Colors.white),
        )
      ],
    );
  }
}
