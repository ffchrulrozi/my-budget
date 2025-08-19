import 'package:my_budget/data/drift/app_database.dart';

class SettingState {
  final bool? hasBeenInitialed;
  final String? appTheme;
  final String? appLanguage;
  final int? monthlyLimit;
  final List<Type> types;
  final List<Category> categories;

  SettingState({
    this.hasBeenInitialed,
    this.appTheme,
    this.appLanguage,
    this.monthlyLimit,
    this.types = const [],
    this.categories = const [],
  });

  SettingState copyWith(
      {bool? hasBeenInitialed,
      String? appTheme,
      String? appLanguage,
      int? monthlyLimit,
      List<Type>? types,
      List<Category>? categories}) {
    return SettingState(
      hasBeenInitialed: hasBeenInitialed ?? this.hasBeenInitialed,
      appTheme: appTheme ?? this.appTheme,
      appLanguage: appLanguage ?? this.appLanguage,
      monthlyLimit: monthlyLimit ?? this.monthlyLimit,
      types: types ?? this.types,
      categories: categories ?? this.categories,
    );
  }
}
