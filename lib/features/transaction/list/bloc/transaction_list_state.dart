import 'package:equatable/equatable.dart';
import 'package:my_budget/data/drift/app_database.dart';

class TransactionListState extends Equatable {
  final Summary? summary;
  final List<TransactionListResult> transactions;
  final List<Type> types;
  final bool isLoading;

  const TransactionListState({
    this.summary,
    this.transactions = const [],
    this.types = const [],
    this.isLoading = false,
  });

  TransactionListState copyWith({
    Summary? summary,
    List<TransactionListResult>? transactions,
    List<Type>? types,
    bool? isLoading,
  }) {
    return TransactionListState(
      summary: summary ?? this.summary,
      transactions: transactions ?? this.transactions,
      types: types ?? this.types,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [types, isLoading];
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
