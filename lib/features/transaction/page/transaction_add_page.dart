import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_budget/features/transaction/bloc/transaction_bloc.dart';
import 'package:my_budget/features/transaction/bloc/transaction_event.dart';
import 'package:my_budget/features/transaction/bloc/transaction_state.dart';
import 'package:my_budget/routes/paths.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';

class TransactionAddPage extends StatelessWidget {
  const TransactionAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final bloc = context.read<TransactionBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Add Transaction"),
        titleSpacing: 0,
      ),
      body: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {
        if (state.isSaved) {
          context.push(Paths.DASHBOARD);
        }
      }, builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'title',
                  decoration: InputDecoration(labelText: "Title"),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                ),
                v(1),
                FormBuilderTextField(
                  name: 'desc',
                  decoration: InputDecoration(labelText: "Description"),
                ),
                v(1),
                FormBuilderDateTimePicker(
                  name: 'date',
                  initialValue: DateTime.now(),
                  decoration: InputDecoration(labelText: "Date"),
                  inputType: InputType.date,
                  format: DateFormat('yyyy-MM-dd'),
                ),
                v(1),
                FormBuilderTextField(
                  name: 'amount',
                  decoration: InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                ),
                v(1),
                FormBuilderRadioGroup<int>(
                    name: 'type',
                    decoration: InputDecoration(
                        labelText: "Type", border: InputBorder.none),
                    initialValue:
                        state.types.isEmpty ? null : state.types[0].id,
                    options: state.types
                        .map((type) => FormBuilderFieldOption(
                            value: type.id, child: Text(type.name)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) bloc.add(TypeChanged(value));
                    }),
                h(1),
                FormBuilderDropdown<int>(
                  name: 'category',
                  decoration: InputDecoration(labelText: "Category"),
                  initialValue:
                      state.categories.isEmpty ? null : state.categories[0].id,
                  items: state.categories
                      .map((category) => DropdownMenuItem(
                          value: category.id, child: Text(category.name)))
                      .toList(),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form != null && form.saveAndValidate()) {
                      bloc.add(
                        CreateTransaction(
                          form.value["date"],
                          form.value["title"],
                          form.value["desc"],
                          int.parse(form.value["amount"]),
                          form.value["type"],
                          form.value["category"],
                        ),
                      );
                    }
                  },
                  child: Text("Save"),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
