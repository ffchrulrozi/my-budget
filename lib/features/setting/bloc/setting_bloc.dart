import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/data/drift/daos/category_dao.dart';
import 'package:my_budget/data/drift/daos/type_dao.dart';
import 'package:my_budget/features/setting/bloc/setting_event.dart';
import 'package:my_budget/features/setting/bloc/setting_state.dart';
import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/features/setting/models/setting.dart';
import 'package:my_budget/main.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AppDatabase db = getIt<AppDatabase>();
  final TypeDao typeDao = getIt<TypeDao>();
  final CategoryDao categoryDao = getIt<CategoryDao>();

  SettingBloc() : super(SettingState()) {
    on<Init>(_Init);
    on<ChangeCategoryType>(_ChangeCategoryType);
    on<UpdateAppTheme>(_UpdateAppTheme);
    on<UpdateLanguage>(_UpdateLanguage);
    on<Save>(_Save);

    add(Init());
  }

  _Init(event, Emitter<SettingState> emit) async {
    final setting = await db.select(db.settings).get();

    emit(SettingState(
      hasBeenInitialed: true,
      appTheme:
          setting.where((x) => x.code == SettingCode.APP_THEME).first.value,
      appLanguage:
          setting.where((x) => x.code == SettingCode.APP_LANGUAGE).first.value,
      monthlyLimit: int.parse(setting
          .where((x) => x.code == SettingCode.MONTHLY_LIMIT)
          .first
          .value),
      types: await typeDao.getAll(),
      categories: await categoryDao.getByType(1),
    ));
  }

  _ChangeCategoryType(
      ChangeCategoryType event, Emitter<SettingState> emit) async {
    emit(state.copyWith(
      categories: await categoryDao.getByType(event.typeId),
    ));
  }

  _UpdateAppTheme(event, emit) async {
    final appTheme = (await (db.select(db.settings)
              ..where((x) => x.code.equals(SettingCode.APP_THEME)))
            .getSingle())
        .value;

    final lightOrDark =
        appTheme == APP_THEME.LIGHT ? APP_THEME.DARK : APP_THEME.LIGHT;

    await (db.update(db.settings)
          ..where((x) => x.code.equals(SettingCode.APP_THEME)))
        .write(
      SettingsCompanion(
        value: Value(lightOrDark),
      ),
    );

    emit(state.copyWith(appTheme: lightOrDark));
  }

  _UpdateLanguage(event, emit) async {
    final appLanguage = (await (db.select(db.settings)
              ..where((x) => x.code.equals(SettingCode.APP_LANGUAGE)))
            .getSingle())
        .value;

    await (db.update(db.settings)
          ..where((x) => x.code.equals(SettingCode.APP_LANGUAGE)))
        .write(
      SettingsCompanion(
        value: Value(
            appLanguage == APP_LANGUAGE.EN ? APP_LANGUAGE.ID : APP_LANGUAGE.EN),
      ),
    );
  }

  _Save(Save event, emit) async {
    // handling delete current categories
    final currentCategories = await db.select(db.categories).get();
    for (int i = 0; i < currentCategories.length; i++) {
      final currentCategoryId = currentCategories[i].id;

      final isAny = event.categories.any((x) => x.id == currentCategoryId);
      if (!isAny) {
        await (db.delete(db.categories)
              ..where((x) => x.id.equals(currentCategoryId)))
            .go();
      }
    }

    for (int i = 0; i < event.categories.length; i++) {
      final category = event.categories[i];
      if (category.id == null) {
        // handling insert new category
        await db.into(db.categories).insert(CategoriesCompanion.insert(
              typeId: Value(category.typeId),
              icon: category.icon,
              name: category.name,
            ));
      } else {
        // handling update current category
        await (db.update(db.categories)
              ..where((x) => x.id.equals(category.id!)))
            .write(
          CategoriesCompanion(
            typeId: Value(category.typeId),
            icon: Value(category.icon),
            name: Value(category.name),
          ),
        );
      }
    }
  }
}
