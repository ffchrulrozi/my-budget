import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart' as m;
import 'package:my_budget/data/drift/tables/categories.dart';
import 'package:my_budget/data/drift/tables/transactions.dart';
import 'package:my_budget/data/drift/tables/types.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'app_database.g.dart';

@DriftDatabase(tables: [Types, Categories, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        beforeOpen: (details) async {
          if (details.wasCreated) {
            await _seedData();
          }
        },
      );

  Future<void> _seedData() async {
    final outcomeId = await into(types).insert(
      TypesCompanion.insert(id: Value(1), name: 'Outcome'),
    );
    final incomeId = await into(types).insert(
      TypesCompanion.insert(id: Value(2), name: 'Income'),
    );

    await into(categories).insert(
      CategoriesCompanion.insert(
        name: 'Food',
        typeId: Value(outcomeId),
        icon: m.Icons.food_bank.codePoint,
      ),
    );
    await into(categories).insert(
      CategoriesCompanion.insert(
        name: 'Transportation',
        typeId: Value(outcomeId),
        icon: m.Icons.motorcycle.codePoint,
      ),
    );
    await into(categories).insert(
      CategoriesCompanion.insert(
        name: 'Monthly Salary',
        typeId: Value(incomeId),
        icon: m.Icons.work.codePoint,
      ),
    );
    await into(categories).insert(
      CategoriesCompanion.insert(
        name: 'From Person',
        typeId: Value(incomeId),
        icon: m.Icons.person.codePoint,
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
