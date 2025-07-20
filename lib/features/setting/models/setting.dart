import 'package:my_budget/data/models/category.dart';

class Setting {
  final String language;
  final bool isAppBgLight;
  final int monthlyLimit;
  final List<Category>? categories;

  Setting({
    required this.language,
    required this.isAppBgLight,
    required this.monthlyLimit,
    this.categories,
  });
}
