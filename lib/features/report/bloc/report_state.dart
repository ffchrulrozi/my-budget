import 'package:my_budget/data/drift/app_database.dart';

class ReportState {
  final Summary? summary;
  final List<CategoryResult> categories;
  final List<Type> types;
  final bool isLoading;
  final Filter? filter;

  const ReportState({
    this.summary,
    this.categories = const [],
    this.types = const [],
    this.isLoading = false,
    this.filter,
  });

  ReportState copyWith({
    final Summary? summary,
    final List<CategoryResult>? categories,
    final List<Type>? types,
    final bool? isLoading,
    final Filter? filter,
  }) {
    return ReportState(
      summary: summary ?? this.summary,
      categories: categories ?? this.categories,
      types: types ?? this.types,
      isLoading: isLoading ?? this.isLoading,
      filter: filter ?? this.filter,
    );
  }
}

class Summary {
  final int outcome;
  final int income;
  Summary(this.outcome, this.income);
}

class CategoryResult {
  final int? icon;
  final String? categoryName;
  final int? amount;
  final double? avg;

  CategoryResult({this.icon, this.categoryName, this.amount, this.avg});
}

class Filter {
  final String? dateType;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? typeId;
  Filter({this.dateType, this.startDate, this.endDate, this.typeId});

  Filter copyWith({
    String? dateType,
    DateTime? startDate,
    DateTime? endDate,
    int? typeId,
  }) {
    return Filter(
      dateType: dateType ?? this.dateType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      typeId: typeId ?? this.typeId,
    );
  }
}

class FilterDateType {
  static const String TODAY = "today";
  static const String LAST7DAYS = "last7Days";
  static const String THISMONTH = "thisMonth";
  static const String LAST30DAYS = "last30Days";
  static const String CUSTOM = "custom";
}
