abstract class SettingEvent {}

class Init extends SettingEvent {}

class ChangeCategoryType extends SettingEvent {
  final int typeId;

  ChangeCategoryType(this.typeId);
}

class UpdateAppTheme extends SettingEvent {}

class UpdateLanguage extends SettingEvent {}

class Save extends SettingEvent {
  final int monthlyLimit;
  final List<CategoryForm> categories;

  Save({required this.monthlyLimit, required this.categories});
}

class CategoryForm {
  final int? id;
  final int typeId;
  final int icon;
  final String name;
  final int color;

  CategoryForm(this.id, this.typeId, this.icon, this.name, this.color);
}
