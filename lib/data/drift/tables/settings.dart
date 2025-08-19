import 'package:drift/drift.dart';

class Settings extends Table {
  TextColumn get code => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {code};
}