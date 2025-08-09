import 'package:drift/drift.dart';
import 'package:my_budget/data/drift/tables/categories.dart';
import 'package:my_budget/data/drift/tables/types.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  TextColumn get title => text()();
  TextColumn get desc => text()();
  IntColumn get amount => integer()();
  IntColumn get typeId => integer().nullable().references(Types, #id)();
  IntColumn get categoryId => integer().nullable().references(Categories, #id)();
}
