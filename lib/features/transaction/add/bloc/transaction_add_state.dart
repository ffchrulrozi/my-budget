import 'package:equatable/equatable.dart';
import 'package:my_budget/data/drift/app_database.dart';

class TransactionAddState extends Equatable {
  final List<Type> types;
  final List<Category> categories;
  final bool isLoading;
  final bool isSaved;

  const TransactionAddState({
    this.types = const [],
    this.categories = const [],
    this.isLoading = false,
    this.isSaved = false,
  });

  TransactionAddState copyWith({
    List<Type>? types,
    List<Category>? categories,
    bool? isLoading,
    bool? isSaved,
  }) {
    return TransactionAddState(
      types: types ?? this.types,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [types, categories, isLoading, isSaved];
}
