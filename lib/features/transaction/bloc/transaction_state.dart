import 'package:equatable/equatable.dart';
import 'package:my_budget/data/drift/app_database.dart';

class TransactionState extends Equatable {
  final Summary? summary;
  final List<TransactionListResult> transactions;
  final List<Type> types;
  final List<Category> categories;
  final bool isLoading;
  final bool isSaved;

  const TransactionState({
    this.summary,
    this.transactions = const [],
    this.types = const [],
    this.categories = const [],
    this.isLoading = false,
    this.isSaved = false,
  });

  TransactionState copyWith({
    Summary? summary,
    List<TransactionListResult>? transactions,
    List<Type>? types,
    List<Category>? categories,
    bool? isLoading,
    bool? isSaved,
  }) {
    return TransactionState(
      summary: summary ?? this.summary,
      transactions: transactions ?? this.transactions,
      types: types ?? this.types,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [types, categories, isLoading, isSaved];
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
