import 'package:drift/drift.dart';

class Types extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}