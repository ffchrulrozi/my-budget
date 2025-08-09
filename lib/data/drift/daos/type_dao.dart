import 'package:drift/drift.dart';
import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/data/drift/tables/types.dart';

part 'type_dao.g.dart';

@DriftAccessor(tables: [Types])
class TypeDao extends DatabaseAccessor<AppDatabase> with _$TypeDaoMixin {
  TypeDao(super.db);

  Future<List<Type>> getAll() => select(types).get();
}
