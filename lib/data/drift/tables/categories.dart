import 'package:drift/drift.dart';
import 'package:my_budget/data/drift/tables/types.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get typeId => integer().nullable().references(Types, #id)();
  IntColumn get icon => integer()();
  TextColumn get name => text()();
}
