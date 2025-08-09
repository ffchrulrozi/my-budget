import 'package:flutter/material.dart';
import 'package:my_budget/features/transaction/bloc/transaction_bloc.dart';
import 'package:my_budget/features/transaction/bloc/transaction_event.dart';
import 'package:my_budget/features/transaction/bloc/transaction_state.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';
import 'package:my_budget/utils/helper/money_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';

class ItemBoxWidget extends StatelessWidget {
  final TransactionBloc bloc;
  final TransactionState state;
  const ItemBoxWidget(this.bloc, this.state, {super.key});

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
                            // Icon(IconData(
                            //   transaction.icon,
                            //   fontFamily: 'MaterialIcons',
                            // )),
                            h(2),
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
