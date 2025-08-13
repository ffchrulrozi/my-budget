import 'package:drift/drift.dart';

class Types extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
}