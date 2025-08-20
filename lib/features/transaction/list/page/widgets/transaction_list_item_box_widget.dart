import 'package:flutter/material.dart';
import 'package:my_budget/features/dashboard/models/dashboard_page_setting.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_bloc.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_event.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_state.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';
import 'package:my_budget/utils/helper/number_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';
import 'package:my_budget/widgets/category_icon_box_widget.dart';

class ItemBoxWidget extends StatelessWidget {
  final TransactionListBloc bloc;
  final TransactionListState state;
  final DashboardPageSetting pageSetting;
  const ItemBoxWidget(this.bloc, this.state, this.pageSetting, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: state.isLoading
            ? Center(child: CircularProgressIndicator())
            : state.transactions.isEmpty
                ? Center(child: Text("No data"))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = state.transactions[index];

                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            CategoryIconBoxWidget(
                              transaction.icon,
                              pageSetting.color,
                            ),
                            h(1),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction.title,
                                  style: text(context).bodyLarge,
                                ),
                                Text(transaction.desc),
                              ],
                            ),
                            Spacer(),
                            Text(
                              Rupiah(transaction.amount),
                              style: text(context).titleMedium,
                            ),
                            h(2),
                            Row(
                              children: [
                                Icon(Icons.edit, color: Colors.orange),
                                h(0.5),
                                InkWell(
                                  onTap: () => bloc
                                      .add(DeleteTransaction(transaction.id)),
                                  child: Icon(Icons.delete, color: Colors.red),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
