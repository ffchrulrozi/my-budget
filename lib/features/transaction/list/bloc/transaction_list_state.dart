import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_event.dart';

class TransactionListState {
  final Summary? summary;
  final List<TransactionListResult> transactions;
  final List<Type> types;
  final bool isLoading;
  final Filter? filter;

  const TransactionListState({
    this.summary,
    this.transactions = const [],
    this.types = const [],
    this.isLoading = false,
    this.filter,
  });

  TransactionListState copyWith({
    Summary? summary,
    List<TransactionListResult>? transactions,
    List<Type>? types,
    bool? isLoading,
    Filter? filter,
  }) {
    return TransactionListState(
      summary: summary ?? this.summary,
      transactions: transactions ?? this.transactions,
      types: types ?? this.types,
      isLoading: isLoading ?? this.isLoading,
      filter: filter ?? this.filter,
    );
  }
}

class Summary {
  final int income;
  final int outcome;
  Summary(this.income, this.outcome);
}

class TransactionListResult {
  final int id;
  final DateTime date;
  final String title;
  final String desc;
  final int amount;
  final String categoryName;
  final int icon;

  TransactionListResult({
    required this.id,
    required this.date,
    required this.title,
    required this.desc,
    required this.amount,
    required this.categoryName,
    required this.icon,
  });
}

class Filter {
  final DateTime? date;
  final int? typeId;
  Filter({this.date, this.typeId});

  Filter copyWith({
    DateTime? date,
    int? typeId,
  }) {
    return Filter(date: date ?? this.date, typeId: typeId ?? this.typeId);
  }
}
